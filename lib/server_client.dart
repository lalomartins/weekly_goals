import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

import 'config.dart';
import 'date_util.dart';
import 'db.dart';
import 'generated/google/protobuf/timestamp.pb.dart';
import 'generated/service.pbgrpc.dart';
import 'generated/types.pb.dart' as pbTypes;

const _applicationId = 'lalomartins.info/apps/weekly-goals';

GetEventsRequest _getEventsRequest() => GetEventsRequest()
  ..filter = (pbTypes.EventsFilter()
    ..account = utf8.encode(config.serverAccount)
    ..application = _applicationId);

class ServerClient {
  ClientChannel _channel;
  EventServerClient _client;
  bool syncing = false;

  ServerClient() {
    _openChannel();
    config.addListener(_openChannel);
  }

  void _openChannel() {
    var url = Uri.tryParse(config.serverAddress);
    if (url == null || url.host.isEmpty) url = Uri(host: config.serverAddress, port: 50051);
    _channel = ClientChannel(
      url.host,
      port: url.hasPort ? url.port : 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    _client = EventServerClient(_channel,
        options: CallOptions(
          timeout: Duration(seconds: 30),
          metadata: {"AuthToken": config.serverToken},
        ));
  }

  Future<void> sync(WeeklyGoalsDatabase db) async {
    if (syncing) return;

    syncing = true;

    print('syncing from server');
    try {
      List<Future<void>> dbOps = [];
      await for (final res in _client.getEvents(_getEventsRequest())) {
        if (res.result.hasError()) {
          throw res.result.error;
        } else {
          final data = res.result.event;
          final event = EventsCompanion.insert(
            uuid: Uuid.unparse(data.uuid),
            type: data.type,
            name: data.name,
            description: Value(data.description),
            timestamp: data.timestamp.toDateTime(),
            timezone: data.timezone.name,
            timezoneOffset: data.timezone.offset,
            realTime: Value(data.realTime),
            additional: Value(data.additionalYaml),
            synced: Value(data.synced.toDateTime()),
          );
          dbOps.add(db.upsertEvent(event));
        }
      }
      print('saving ${dbOps.length} events received from server');
      await Future.wait(dbOps);
    } catch (e) {
      print('SYNC ERROR: $e');
      syncing = false;
      throw e;
    }

    final toSync = await db.unsyncedEvents;
    final Map<String, Event> map = Map();
    print('syncing ${toSync.length} events to server');
    Stream<PushEventsRequest> outgoing = Stream.fromIterable(toSync.map((e) {
      map[e.uuid] = e;
      return PushEventsRequest()
        ..event = (pbTypes.Event()
          ..uuid = Uuid.parse(e.uuid)
          ..account = utf8.encode(config.serverAccount)
          ..application = _applicationId
          ..type = e.type
          ..name = e.name
          ..description = e.description
          ..timestamp = Timestamp.fromDateTime(e.timestamp)
          ..timezone = (pbTypes.Timezone()
            ..name = e.timezone
            ..offset = timeZone(e.timezone, e.timestamp.millisecondsSinceEpoch).offset ~/ 1000)
          ..realTime = e.realTime
          ..additionalYaml = e.additional);
    }));
    int i = 0;
    try {
      await for (final response in _client.pushEvents(outgoing)) {
        final res = response.result;
        if (res.hasError())
          print('Got error ${res.error.code} ${res.error.message} syncing ${toSync[i].uuid}');
        else {
          final evUuid = Uuid.unparse(res.event.uuid);
          final event = map[evUuid].copyWith(synced: res.event.synced.toDateTime());
          // print(
          //     'Got event ${event.uuid} (${res.event.type}/${res.event.name}) synced at ${res.event.synced}');
          await db.updateEvent(event);
        }
        i++;
      }
      db.refreshGoals();
      print('sync finished');
    } finally {
      syncing = false;
    }
  }
}
