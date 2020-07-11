import 'package:flutter/material.dart';

import '../date_util.dart';
import 'calendar_day.dart';
import 'goals_for_the_week.dart';
import 'mini_week_report.dart';

class Calendar extends StatelessWidget {
  final DateTime start;
  final int weeksAgo;
  const Calendar({
    Key key,
    this.start,
    this.weeksAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = date();
    Widget day(int weekday) {
      final dt = start.add(Duration(days: weekday));
      return CalendarDay(day: dt, highlight: weeksAgo == 0 && dt.day == today.day);
    }

    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Row(
            children: <Widget>[
              Flexible(
                  flex: 1,
                  child: (weeksAgo != 0)
                      ? MiniWeekReport(start: start, weeksAgo: weeksAgo)
                      : GoalsForTheWeek()),
              Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(start: BorderSide()))),
              Flexible(flex: 1, child: day(0)),
              Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(start: BorderSide()))),
              Flexible(
                  flex: 1,
                  child: day(1)),
              Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(start: BorderSide()))),
              Flexible(
                  flex: 1,
                  child: day(2)),
            ],
          ),
        ),
        Container(
            decoration:
                BoxDecoration(border: BorderDirectional(top: BorderSide()))),
        Flexible(
          flex: 1,
          child: Row(
            children: <Widget>[
              Flexible(
                  flex: 1,
                  child: day(3)),
              Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(start: BorderSide()))),
              Flexible(
                  flex: 1,
                  child: day(4)),
              Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(start: BorderSide()))),
              Flexible(
                  flex: 1,
                  child: day(5)),
              Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(start: BorderSide()))),
              Flexible(
                  flex: 1,
                  child: day(6)),
            ],
          ),
        ),
      ],
    );
  }
}
