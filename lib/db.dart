import 'dart:convert';
import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
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
            final now = DateTime.now();
            await m.issueCustomQuery('alter table events rename to events_old');
            await m.createAll();
            await m.issueCustomQuery('''
            INSERT INTO events (uuid, type, name, description, timestamp, timezone, real_time, additional)
              SELECT 'mig-${now.millisecondsSinceEpoch.round()}-' || id as uuid,
                type, name, description, timestamp,
                '${now.timeZoneName}' as timezone,
                real_time, additional
              FROM events_old;
            ''');
            m.issueCustomQuery('drop table events_old');
          }
        },
        // beforeOpen: (details) async {
        //   final goalsCount =
        //       await customSelectQuery('select count() as c from cached_goals')
        //           .getSingle();
        //   if (goalsCount.data['c'] == 0) {
        //     // insert stuff
        //     // earliest event: 2020-03-19 19:31:51.000
        //   }
        // },
      );

  Stream<List<Event>> get watchAllEvents => (select(events)
        ..orderBy(
            [(u) => OrderingTerm(expression: u.timestamp, mode: OrderingMode.desc)]))
      .watch();

  Stream<List<Event>> watchRecentEvents({int days}) => (select(events)
        ..where((t) => t.timestamp.isBiggerOrEqualValue(
            DateTime.now().subtract(Duration(days: days))))
        ..orderBy(
            [(u) => OrderingTerm(expression: u.timestamp, mode: OrderingMode.desc)]))
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
      data['uuid'] = uuid.v4();
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
    var ec = Event.fromJson(data).createCompanion(true);
    return into(events).insert(ec);
  }

  Stream<List<Goal>> watchCurrentGoals() => (select(cachedGoals)
        ..orderBy(
            [(u) => OrderingTerm(expression: u.name, mode: OrderingMode.asc)]))
      .map((cached) => Goal.copy(cached))
      .watch();
}
