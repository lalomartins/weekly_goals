import 'config.dart';

const Map<int, String> youbi = {
  DateTime.sunday: '日',
  DateTime.monday: '月',
  DateTime.tuesday: '火',
  DateTime.wednesday: '水',
  DateTime.thursday: '木',
  DateTime.friday: '金',
  DateTime.saturday: '土',
};

DateTime date({DateTime dateTime, bool midnight = false}) {
  dateTime = dateTime ?? DateTime.now().subtract(Duration(minutes: config.dayOffsetMinutes));
  final zh = DateTime(dateTime.year, dateTime.month, dateTime.day);
  return midnight ? zh : zh.add(Duration(minutes: config.dayOffsetMinutes));
}

int weekOffset([DateTime when]) =>
    ((when ?? DateTime.now()).weekday - config.weekStartsOn) % 7;

DateTime startOfWeek({int weeksAgo = 0, bool midnight = false}) {
  final now = DateTime.now().subtract(Duration(minutes: config.dayOffsetMinutes));
  final sow = DateTime(now.year, now.month, now.day).subtract(
      Duration(days: (now.weekday - config.weekStartsOn) % 7 + weeksAgo * 7));
  return midnight ? sow : sow.add(Duration(minutes: config.dayOffsetMinutes));
}
