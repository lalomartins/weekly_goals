import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../date_util.dart';
import '../db.dart';

final timeFormat = DateFormat.Hms();

class CalendarDay extends StatelessWidget {
  final DateTime day;
  final bool showHeader;
  const CalendarDay({
    Key key,
    this.day,
    this.showHeader = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dbProvider = Provider.of<WeeklyGoalsDatabase>(context);

    return StreamBuilder<List<Event>>(
      stream: _dbProvider.watchDayEvents(day: day, type: 'weekly goals'),
      initialData: [],
      builder: (context, snapshot) {
        final events = snapshot.data ?? [];
        final listView = ListView(
          children: events
              .map((event) => Column(
                    children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(children: <Widget>[
                              Text(event.name, style: TextStyle(fontSize: 15)),
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
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                            : []),
                  ))
              .toList(),
        );

        if (showHeader)
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
              child: listView,
            ),
          ]);
        else
          return listView;
      },
    );
  }
}
