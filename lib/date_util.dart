import 'package:flutter/material.dart';

int weekStart(BuildContext context) =>
    MaterialLocalizations.of(context).firstDayOfWeekIndex;

DateTime startOfWeek({int weeksAgo = 0, int weekStartsOn = DateTime.sunday}) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day).subtract(
      Duration(days: (now.weekday - weekStartsOn) % 7 + weeksAgo * 7));
}
