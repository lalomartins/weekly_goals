import 'config.dart';

int weekOffset([DateTime when]) =>
    ((when ?? DateTime.now()).weekday - config.weekStartsOn) % 7;

DateTime startOfWeek({int weeksAgo = 0}) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day).subtract(
      Duration(days: (now.weekday - config.weekStartsOn) % 7 + weeksAgo * 7));
}
