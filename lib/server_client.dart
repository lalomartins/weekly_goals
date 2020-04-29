import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:weekly_goals/generated/google/protobuf/timestamp.pb.dart';
import 'package:weekly_goals/generated/service.pbgrpc.dart';
import 'package:weekly_goals/generated/types.pb.dart' as pbTypes;

import 'config.dart';
import 'db.dart';

final _dummyAccount = utf8.encode('dummy');
const _applicationId = 'lalomartins.info/apps/weekly-goals';

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
    final toSync = await db.unsyncedEvents;
    final Map<String, Event> map = Map();
    print('syncing ${toSync.length} events to server');
    Stream<PushEventsRequest> outgoing = Stream.fromIterable(toSync.map((e) {
      map[e.uuid] = e;
      return PushEventsRequest()
        ..event = (pbTypes.Event()
          ..uuid = uuid.parse(e.uuid)
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
    await for (final response in _client.pushEvents(outgoing)) {
      final res = response.result;
      if (res.hasError())
        print(
            'Got error ${res.error.code} ${res.error.message} syncing ${toSync[i].uuid}');
      else {
        final evUuid = uuid.unparse(res.event.uuid);
        final event =
            map[evUuid].copyWith(synced: res.event.synced.toDateTime());
        // print(
        //     'Got event ${event.uuid} (${res.event.type}/${res.event.name}) synced at ${res.event.synced}');
        await db.updateEvent(event);
      }
      i++;
    }
    print('sync finished');
    syncing = false;
  }
}
