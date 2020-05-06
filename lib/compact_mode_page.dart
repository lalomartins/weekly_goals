import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'date_util.dart';
import 'db.dart';
import 'event_list.dart';
import 'server_client.dart';
import 'widgets/calendar_day.dart';
import 'widgets/drawer_overlay.dart';
import 'widgets/goals_for_the_week.dart';
import 'widgets/mini_week_report.dart';

class CompactModePage extends StatefulWidget {
  const CompactModePage({
    Key key,
  }) : super(key: key);

  @override
  _CompactModePageState createState() => _CompactModePageState();
}

class _CompactModePageState extends State<CompactModePage> {
  int dayOffset = 0;
  var syncError;
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void previousDay() {
    setState(() {
      dayOffset -= 1;
    });
  }

  void nextDay() {
    setState(() {
      dayOffset += 1;
    });
  }

  void resetDay() {
    setState(() {
      dayOffset = 0;
    });
  }

  Future<void> sync(BuildContext context) async {
    final db = Provider.of<WeeklyGoalsDatabase>(context);
    final client = Provider.of<ServerClient>(context);
    try {
      await client.sync(db);
    } catch (e) {
      print('Sync error!');
      print(e);
      setState(() {
        syncError = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final day = date().add(Duration(days: dayOffset));
    final sow = day.subtract(Duration(days: weekOffset(day)));
    final weeksAgo = date().difference(sow).inDays ~/ 7;
    // final eow = sow.add(Duration(days: 6));
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('${youbi[day.weekday]}　・　${day.month}月${day.day}日'),
        actions: dayOffset == 0
            ? <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_left), onPressed: previousDay),
                IconButton(
                    icon: Icon(Icons.sync), onPressed: () => sync(context)),
                IconButton(
                    icon: Icon(Icons.list),
                    onPressed: () => _scaffoldKey.currentState.openEndDrawer()),
              ]
            : <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_left), onPressed: previousDay),
                IconButton(
                    icon: Icon(Icons.sync), onPressed: () => sync(context)),
                IconButton(icon: Icon(Icons.restore), onPressed: resetDay),
                IconButton(icon: Icon(Icons.arrow_right), onPressed: nextDay),
              ],
        bottom: syncError == null
            ? null
            : PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: MaterialBanner(
                  content: Text(
                    'Sync error. Try again later, or check the logs.',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).errorColor,
                  actions: [
                    FlatButton(
                      onPressed: () => setState(() => syncError = null),
                      child: Text(
                        'Dismiss',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
      ),
      body: Column(
        children: [
          Flexible(flex: 1, child: CalendarDay(day: day, showHeader: false)),
          Divider(),
          Flexible(flex: 1, child: (weeksAgo != 0) ? MiniWeekReport(start: sow, weeksAgo: weeksAgo) : GoalsForTheWeek())
        ],
      ),
      endDrawer: DrawerOverlay(drawerContent: EventList(popOnNav: true)),
    );
  }
}
