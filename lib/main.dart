import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_screen.dart';
import 'db.dart';
import 'event_list.dart';

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
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('This week'),
                    ),
                    body: Center(
                      child: EventList(),
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
