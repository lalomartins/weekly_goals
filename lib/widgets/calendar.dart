import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../db.dart';
import 'goals_for_the_week.dart';

class Calendar extends StatelessWidget {
  final DateTime start;
  const Calendar({
    Key key,
    this.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Row(
            children: <Widget>[
              Flexible(flex: 1, child: GoalsForTheWeek()),
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

const Map<int, String> youbi = {
  DateTime.sunday: '日',
  DateTime.monday: '月',
  DateTime.tuesday: '火',
  DateTime.wednesday: '水',
  DateTime.thursday: '木',
  DateTime.friday: '金',
  DateTime.saturday: '土',
};

final timeFormat = DateFormat.Hms();

class CalendarDay extends StatelessWidget {
  final DateTime day;
  const CalendarDay({
    Key key,
    this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dbProvider = Provider.of<WeeklyGoalsDatabase>(context);

    return StreamBuilder<List<Event>>(
      stream: _dbProvider.watchDayEvents(day: day, type: 'weekly goals'),
      initialData: [],
      builder: (context, snapshot) {
        final events = snapshot.data ?? [];
        return Column(children: <Widget>[
          Container(
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
            ),
            // Eventually we want to use local formats, but for now since I like it in Japanese,
            // until I add a locale override feature or something, I'll hardcode it
            child: Text('${youbi[day.weekday]} ${day.day}',
                style: Theme.of(context).primaryTextTheme.title),
          ),
          Expanded(
            child: ListView(
              children: events
                  .map((event) => Column(
                        children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(children: <Widget>[
                                  Text(event.name,
                                      style: TextStyle(fontSize: 15)),
                                  Spacer(),
                                  Text(
                                      timeFormat.format(event.timestamp) +
                                          (event.realTime ? '' : ' (recorded)'),
                                      style: TextStyle(
                                          fontSize: 8,
                                          fontStyle: FontStyle.italic)),
                                ]),
                              )
                            ] +
                            ((event.description != null &&
                                    event.description.isNotEmpty)
                                ? [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              event.description,
                                              softWrap: true,
                                              // textAlign: TextAlign.start,
                                              maxLines: 3,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]
                                : []),
                      ))
                  .toList(),
            ),
          ),
        ]);
      },
    );
  }
}
