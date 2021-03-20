import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:weekly_goals/event_list.dart';

import 'add_screen.dart';
import 'compact_mode_page.dart';
import 'config.dart';
import 'calendar_page.dart';
import 'db.dart';
import 'edit_screen.dart';
import 'server_client.dart';
import 'settings_screen.dart';
import 'theme.dart';

void main() {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  config.load().then((_) => runApp(AppRoot()));
}

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Config>.value(value: config),
        ChangeNotifierProvider<ThemeNotifier>.value(value: config.themeNotifier),
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
          initialData: null,
        ),
        FutureProvider<PackageInfo>(create: (_) => PackageInfo.fromPlatform(), initialData: null),
      ],
      child: WeeklyGoalsApp(),
    );
  }
}

class WeeklyGoalsApp extends StatelessWidget {
  const WeeklyGoalsApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Weekly Goals',
      theme: wgLightTheme,
      darkTheme: wgDarkTheme,
      themeMode: themeNotifier.value,
      initialRoute: '/',
      routes: {
        '/': (context) => OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                config.useLocaleDefaults(context);
                return orientation == Orientation.landscape ? CalendarPage() : CompactModePage();
              },
            ),
        'settings': (context) => SettingsScreen(),
        'add': (context) => AddScreen(),
        'edit': (context) => EditScreen(),
        'events': (context) => EventListPage(),
      },
    );
  }
}
