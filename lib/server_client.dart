import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:moor/moor.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

import 'config.dart';
import 'db.dart';
import 'generated/google/protobuf/timestamp.pb.dart';
import 'generated/service.pbgrpc.dart';
import 'generated/types.pb.dart' as pbTypes;

final _dummyAccount = utf8.encode('dummy');
const _applicationId = 'lalomartins.info/apps/weekly-goals';
final _getEventsRequest = GetEventsRequest()
  ..filter = (pbTypes.EventsFilter()
    ..account = _dummyAccount
    ..application = _applicationId
  );

class ServerClient {
  ClientChannel _channel;
  EventServerClient _client;
  bool syncing = false;

  ServerClient() {
    _openChannel(config.serverAddress);
  }

  void _openChannel(address) {
    final url = Uri.tryParse(address) ?? Uri(host: address);
    _channel = ClientChannel(
      url.host,
      port: url.hasPort ? url.port : 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    _client = EventServerClient(_channel,
        options: CallOptions(timeout: Duration(seconds: 30)));
  }

  Future<void> sync(WeeklyGoalsDatabase db) async {
    if (syncing) return;

    syncing = true;

    print('syncing from server');
    try {
      List<Future<void>> dbOps = [];
      await for (final res in _client.getEvents(_getEventsRequest)) {
        if (res.result.hasError()) {
          print('SYNC ERROR received: ${res.result.error}');
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
    }

    final toSync = await db.unsyncedEvents;
    final Map<String, Event> map = Map();
    print('syncing ${toSync.length} events to server');
    Stream<PushEventsRequest> outgoing = Stream.fromIterable(toSync.map((e) {
      map[e.uuid] = e;
      return PushEventsRequest()
        ..event = (pbTypes.Event()
          ..uuid = Uuid.parse(e.uuid)
          ..account = _dummyAccount
          ..application = _applicationId
          ..type = e.type
          ..name = e.name
          ..description = e.description
          ..timestamp = Timestamp.fromDateTime(e.timestamp)
          ..timezone = (pbTypes.Timezone()
            ..name = e.timezone
            ..offset = tz
                    .getLocation(e.timezone)
                    .timeZone(e.timestamp.millisecondsSinceEpoch)
                    .offset ~/
                1000)
          ..realTime = e.realTime
          ..additionalYaml = e.additional);
    }));
    int i = 0;
    try {
      await for (final response in _client.pushEvents(outgoing)) {
        final res = response.result;
        if (res.hasError())
          print(
              'Got error ${res.error.code} ${res.error.message} syncing ${toSync[i].uuid}');
        else {
          final evUuid = Uuid.unparse(res.event.uuid);
          final event =
              map[evUuid].copyWith(synced: res.event.synced.toDateTime());
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
