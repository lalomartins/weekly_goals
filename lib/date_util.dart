import 'config.dart';

int weekOffset([DateTime when]) =>
    ((when ?? DateTime.now()).weekday - config.weekStartsOn) % 7;

DateTime startOfWeek({int weeksAgo = 0, bool midnight = false}) {
  final now = DateTime.now();
  final sow = DateTime(now.year, now.month, now.day).subtract(
      Duration(days: (now.weekday - config.weekStartsOn) % 7 + weeksAgo * 7));
  return midnight ? sow : sow.add(Duration(minutes: config.dayOffsetMinutes));
}
