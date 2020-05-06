import 'dart:convert';
import 'dart:io';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';
import 'package:yaml/yaml.dart';

// import 'config.dart';
import 'date_util.dart';
import 'model/goal.dart';
export 'model/goal.dart' show Goal;

part 'db.g.dart';

final uuid = Uuid();

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getExternalStorageDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(
  include: {'model/event.moor', 'model/goal.moor'},
)
class WeeklyGoalsDatabase extends _$WeeklyGoalsDatabase {
  WeeklyGoalsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) {
          return m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from == 1) {
            await m.issueCustomQuery('alter table events rename to events_old');
            await m.createAll();
          }
        },
        beforeOpen: (details) async {
          if (details.versionBefore == 1) {
            var loc = tz.UTC;
            try {
              final name = await FlutterNativeTimezone.getLocalTimezone();
              loc = tz.getLocation(name);
            } catch (e) {
              print('WARNING, failed to detect timezone');
            }
            for (final row in await customSelectQuery('select * from events_old').get()) {
              final event = events.map(row.data);
              var zone = loc.timeZone(event.timestamp.millisecondsSinceEpoch);
              await into(events).insert(event.copyWith(
                uuid: uuid.v1(options: {
                  'msecs': event.timestamp.millisecondsSinceEpoch,
                  'nsecs': event.timestamp.microsecond * 10,
                }),
                timezone: loc.name,
                timezoneOffset: zone.offset ~/ 1000,
              ));
            }
            await customStatement('drop table events_old');
          }
          // final goalsCount =
          //     await customSelectQuery('select count() as c from cached_goals')
          //         .getSingle();
          // if (goalsCount.data['c'] == 0) {
          //   // insert stuff
          //   // earliest event: 2020-03-19 19:31:51.000
          // }
        },
      );

  Stream<List<Event>> get watchAllEvents => (select(events)
        ..orderBy([
          (u) => OrderingTerm(expression: u.timestamp, mode: OrderingMode.desc)
        ]))
      .watch();

  Future<List<Event>> get unsyncedEvents => (select(events)
        ..where((t) => isNull(t.synced))
        ..orderBy([
          (u) => OrderingTerm(expression: u.timestamp, mode: OrderingMode.asc)
        ]))
      .get();

  Stream<List<Event>> watchRecentEvents({int days}) => (select(events)
        ..where((t) => t.timestamp.isBiggerOrEqualValue(
            DateTime.now().subtract(Duration(days: days))))
        ..orderBy([
          (u) => OrderingTerm(expression: u.timestamp, mode: OrderingMode.desc)
        ]))
      .watch();

  Stream<List<Event>> watchWeekEvents({int weeksAgo = 0, String type}) {
    final sow = startOfWeek(weeksAgo: weeksAgo);
    final query = select(events);
    if (type == null)
      query.where((t) =>
          t.timestamp.isBiggerOrEqualValue(sow) &
          t.timestamp.isSmallerThanValue(sow.add(Duration(days: 7))));
    else
      query.where((t) =>
          t.timestamp.isBiggerOrEqualValue(sow) &
          t.timestamp.isSmallerThanValue(sow.add(Duration(days: 7))) &
          t.type.equals(type));
    query.orderBy(
        [(u) => OrderingTerm(expression: u.timestamp, mode: OrderingMode.asc)]);
    return query.watch();
  }

  Stream<List<Event>> watchDayEvents({DateTime day, String type}) {
    final query = select(events);
    if (type == null)
      query.where((t) =>
          t.timestamp.isBiggerOrEqualValue(day) &
          t.timestamp.isSmallerThanValue(day.add(Duration(days: 1))));
    else
      query.where((t) =>
          t.timestamp.isBiggerOrEqualValue(day) &
          t.timestamp.isSmallerThanValue(day.add(Duration(days: 1))) &
          t.type.equals(type));
    query.orderBy(
        [(u) => OrderingTerm(expression: u.timestamp, mode: OrderingMode.asc)]);
    return query.watch();
  }

  Future<int> createEventFromMap(Map<String, dynamic> data) {
    bool copied = false;
    if (data['uuid'] == null) {
      data = data.map((k, v) => MapEntry(k, v));
      copied = true;
      data['uuid'] = uuid.v1();
    }
    if (data['synced'] != null) {
      data = data.map((k, v) => MapEntry(k, v));
      copied = true;
      data['synced'] = null;
    }
    if (data['timestamp'] is DateTime) {
      data = data.map((k, v) => MapEntry(k, v));
      copied = true;
      data['timestamp'] =
          (data['timestamp'] as DateTime).millisecondsSinceEpoch;
    }
    String additional = data['additional'];
    if (additional != null &&
        additional.isNotEmpty &&
        !additional.startsWith('{')) {
      if (!copied) {
        data = data.map((k, v) => MapEntry(k, v));
        copied = true;
      }
      data['additional'] = json.encode(loadYaml(additional));
    }
    final event = Event.fromJson(data);
    return into(events).insert(event);
  }

  Future<void> updateEvent(Event event) => update(events).replace(event);
  Future<void> upsertEvent(EventsCompanion event) => into(events).insertOnConflictUpdate(event);

  Stream<List<Goal>> watchCurrentGoals() => (select(cachedGoals)
        ..orderBy(
            [(u) => OrderingTerm(expression: u.name, mode: OrderingMode.asc)]))
      .map((cached) => Goal.copy(cached))
      .watch();
}
