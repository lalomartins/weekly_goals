import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'date_util.dart';
import 'db.dart';
import 'event_list.dart';
import 'server_client.dart';
import 'widgets/calendar.dart';
import 'widgets/drawer_overlay.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    Key key,
  }) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int weekOffset = 0;
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void previousWeek() {
    setState(() {
      weekOffset -= 1;
    });
  }

  void nextWeek() {
    setState(() {
      weekOffset += 1;
    });
  }

  void resetWeek() {
    setState(() {
      weekOffset = 0;
    });
  }

  void sync(BuildContext context) {
    final db = Provider.of<WeeklyGoalsDatabase>(context);
    final client = Provider.of<ServerClient>(context);
    client.sync(db);
  }

  @override
  Widget build(BuildContext context) {
    final sow = startOfWeek().add(Duration(days: weekOffset * 7));
    final eow = sow.add(Duration(days: 6));
    String weekFormatted;
    // Eventually we want to use local formats, but for now since I like it it Japanese,
    // until I add a locale override feature or something, I'll hardcode it
    if (sow.year != eow.year)
      weekFormatted =
          '${sow.year}年${sow.month}月${sow.day} — ${eow.year}年${eow.month}月${eow.day}日';
    else if (sow.month != eow.month)
      weekFormatted =
          '${sow.year}年${sow.month}月${sow.day}日 — ${eow.month}月${eow.day}日';
    else
      weekFormatted = '${sow.year}年${sow.month}月${sow.day} — ${eow.day}日';
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Week of ' + weekFormatted),
        actions: weekOffset == 0
            ? <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_left), onPressed: previousWeek),
                IconButton(icon: Icon(Icons.sync), onPressed: () => sync(context)),
                IconButton(
                    icon: Icon(Icons.list),
                    onPressed: () => _scaffoldKey.currentState.openEndDrawer()),
              ]
            : <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_left), onPressed: previousWeek),
                IconButton(icon: Icon(Icons.sync), onPressed: () => sync(context)),
                IconButton(
                    icon: Icon(Icons.restore), onPressed: resetWeek),
                IconButton(
                    icon: Icon(Icons.arrow_right), onPressed: nextWeek),
              ],
      ),
      body: Calendar(start: sow, weeksAgo: -weekOffset),
      endDrawer: DrawerOverlay(drawerContent: EventList(popOnNav: true)),
    );
  }
}
