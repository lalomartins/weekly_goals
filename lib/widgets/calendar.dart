import 'package:flutter/material.dart';

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
              Flexible(flex: 1, child: CalendarDay(day: start)),
              Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(start: BorderSide()))),
              Flexible(
                  flex: 1,
                  child: CalendarDay(day: start.add(Duration(days: 1)))),
              Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(start: BorderSide()))),
              Flexible(
                  flex: 1,
                  child: CalendarDay(day: start.add(Duration(days: 2)))),
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
                  child: CalendarDay(day: start.add(Duration(days: 3)))),
              Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(start: BorderSide()))),
              Flexible(
                  flex: 1,
                  child: CalendarDay(day: start.add(Duration(days: 4)))),
              Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(start: BorderSide()))),
              Flexible(
                  flex: 1,
                  child: CalendarDay(day: start.add(Duration(days: 5)))),
              Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(start: BorderSide()))),
              Flexible(
                  flex: 1,
                  child: CalendarDay(day: start.add(Duration(days: 6)))),
            ],
          ),
        ),
      ],
    );
  }
}
