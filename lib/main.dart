import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_screen.dart';
import 'calendar_page.dart';
import 'db.dart';
import 'theme.dart';

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
