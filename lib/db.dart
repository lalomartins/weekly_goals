import 'dart:convert';
import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'date_util.dart';
import 'model/event.dart';

part 'db.g.dart';

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

@UseMoor(tables: [Events])
class EventDatabase extends _$EventDatabase {
  EventDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // @override
  // MigrationStrategy get migration => MigrationStrategy(
  //   onCreate: (Migrator m) {
  //     return m.createAll();
  //   },
  //   onUpgrade: (Migrator m, int from, int to) async {
  //     if (from == 1) {
  //     }
  //   }
  // );

  Stream<List<Event>> get watchAllEvents => (select(events)
        ..orderBy(
            [(u) => OrderingTerm(expression: u.id, mode: OrderingMode.desc)]))
      .watch();

  Stream<List<Event>> watchRecentEvents({int days}) => (select(events)
        ..where((t) => t.timestamp.isBiggerOrEqualValue(
            DateTime.now().subtract(Duration(days: days))))
        ..orderBy(
            [(u) => OrderingTerm(expression: u.id, mode: OrderingMode.desc)]))
      .watch();

  Stream<List<Event>> watchWeekEvents(
      {int weeksAgo = 0, int weekStartsOn, String type}) {
    final sow = startOfWeek(weekStartsOn: weekStartsOn, weeksAgo: weeksAgo);
    final query = select(events);
    // TODO actually if weeksAgo > 0 we want to also cap the upper bound
    if (type == null)
      query.where((t) => t.timestamp.isBiggerOrEqualValue(sow));
    else
      query.where(
          (t) => t.timestamp.isBiggerOrEqualValue(sow) & t.type.equals(type));
    query.orderBy(
        [(u) => OrderingTerm(expression: u.id, mode: OrderingMode.desc)]);
    return query.watch();
  }

  Stream<List<Event>> watchDayEvents(
      {DateTime day, String type}) {
    final query = select(events);
    // TODO actually if weeksAgo > 0 we want to also cap the upper bound
    if (type == null)
      query.where((t) => t.timestamp.isBiggerOrEqualValue(day) & t.timestamp.isSmallerThanValue(day.add(Duration(days: 1))));
    else
      query.where(
          (t) => t.timestamp.isBiggerOrEqualValue(day) & t.timestamp.isSmallerThanValue(day.add(Duration(days: 1))) & t.type.equals(type));
    query.orderBy(
        [(u) => OrderingTerm(expression: u.id, mode: OrderingMode.desc)]);
    return query.watch();
  }

  Future<int> createEventFromMap(Map<String, dynamic> data) {
    bool copied = false;
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
}
