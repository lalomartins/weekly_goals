import 'package:moor/moor.dart';

class Events extends Table {
  // TODO: timezone, uuid
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(Constant(''))();
  DateTimeColumn get timestamp => dateTime().clientDefault(() => DateTime.now())();
  BoolColumn get realTime => boolean().withDefault(Constant(true))();
  TextColumn get additional => text().withDefault(Constant(''))();
}
