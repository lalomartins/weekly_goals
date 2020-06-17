import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'add_screen.dart';
import 'compact_mode_page.dart';
import 'config.dart';
import 'calendar_page.dart';
import 'db.dart';
import 'edit_screen.dart';
import 'server_client.dart';
import 'theme.dart';

void main() {
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WeeklyGoalsDatabase>(
          create: (_) => WeeklyGoalsDatabase(),
        ),
        Provider<ServerClient>(
          create: (_) => ServerClient(),
        ),
        FutureProvider<tz.Location>(
          create: (_) async {
            try {
              final name = await FlutterNativeTimezone.getLocalTimezone();
              tz.setLocalLocation(tz.getLocation(name));
            } catch (e) {
              print('WARNING, failed to detect timezone');
            }
            return tz.local;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Weekly Goals',
        theme: wgLightTheme,
        darkTheme: wgDarkTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              return orientation == Orientation.landscape
              ? CalendarPage()
              : CompactModePage();
            },
          ),
          'add': (context) => AddScreen(),
          'edit': (context) => EditScreen(),
        },
        builder: (context, navi) {
          config.init(context);
          return navi;
        },
      ),
    );
  }
}
