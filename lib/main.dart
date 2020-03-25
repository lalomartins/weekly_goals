import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_screen.dart';
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
              '/': (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('This week'),
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
                  ),
              'add': (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('Add Event'),
                  ),
                  body: AddScreen()),
            }));
  }
}
