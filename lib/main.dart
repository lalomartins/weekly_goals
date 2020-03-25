import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_screen.dart';
import 'date_util.dart';
import 'db.dart';
import 'event_list.dart';
import 'theme.dart';
import 'widgets/goals_for_the_week.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<EventDatabase>(
            create: (_) => EventDatabase(),
          ),
        ],
        child: MaterialApp(
            title: 'Weekly Goals',
            theme: wgLightTheme,
            darkTheme: wgDarkTheme,
            initialRoute: '/',
            routes: {
              '/': (context) => CalendarPage(),
              'add': (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('Add Event'),
                  ),
                  body: AddScreen()),
            }));
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sow = startOfWeek(weekStartsOn: weekStart(context));
    final eow = sow.add(Duration(days: 6));
    String weekFormatted;
    // Eventually we want to use local formats, but for now since I like it it Japanese,
    // until I add a locale override feature or something, I'll hardcode it
    if (sow.year != eow.year)
      weekFormatted = '${sow.year}年${sow.month}月${sow.day} — ${eow.year}年${eow.month}月${eow.day}';
    else if (sow.month != eow.month)
      weekFormatted = '${sow.year}年${sow.month}月${sow.day} — ${eow.month}月${eow.day}';
    else
      weekFormatted = '${sow.year}年${sow.month}月${sow.day} — ${eow.day}';
    return Scaffold(
          appBar: AppBar(
            title: Text('Week of ' + weekFormatted),
          ),
          body: Row(
            children: <Widget>[
              Flexible(flex: 1, child: GoalsForTheWeek()),
              Flexible(flex: 1, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: EventList(),
              )),
            ],
          ),
        );
  }
}
