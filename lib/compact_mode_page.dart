import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/achieve.dart';
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
  PageController pageController;
  PageController weekPageController;
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    pageController = PageController();
    weekPageController = PageController();
    super.initState();
  }

  @override
  void dispose() { 
    pageController.dispose();
    weekPageController.dispose();
    super.dispose();
  }

  void previousDay() {
    pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void nextDay() {
    pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void resetDay() {
    pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Future<void> sync(BuildContext context) async {
    final db = Provider.of<WeeklyGoalsDatabase>(context);
    final client = Provider.of<ServerClient>(context);
    final syncingBar = Flushbar(
        message: 'Sync in progress',
        backgroundColor: Theme.of(context).primaryColor,
      )..show(context);
    try {
      await client.sync(db);
      syncingBar.dismiss();
      Flushbar(
        message: 'Sync completed',
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.sync, color: Theme.of(context).colorScheme.onPrimary),
        duration: Duration(seconds: 30),
      )..show(context);
    } catch (e) {
      syncingBar.dismiss();
      print('Sync error!');
      print(e);
      Flushbar errorBar;
      errorBar = Flushbar(
        message: 'Sync error. Try again later, or check the logs.',
        backgroundColor: Theme.of(context).errorColor,
        icon: Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
        mainButton: FlatButton(
          child: Text('dismiss', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          onPressed: () => errorBar.dismiss(),
        ),
        duration: Duration(seconds: 60),
      )..show(context);
    }
  }

  void handleDayChanged(offset) {
    setState(() => dayOffset = -offset);
    final weekday = weekOffset(date());
    final weeks = (weekday - dayOffset) ~/ 7;
    if (weekPageController.page != weeks)
      weekPageController.animateToPage(weeks, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final today = date();
    final weekday = weekOffset(today);
    final day = today.add(Duration(days: dayOffset));
    final sow = day.subtract(Duration(days: weekOffset(day)));
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('${youbi[day.weekday]}　・　${day.month}月${day.day}日'),
        actions: dayOffset == 0
            ? <Widget>[
                IconButton(icon: Icon(Icons.arrow_left), onPressed: previousDay),
                IconButton(icon: Icon(Icons.check_circle_outline), onPressed: () => AchieveForm.popup(context)),
                IconButton(icon: Icon(Icons.sync), onPressed: () => sync(context)),
                IconButton(icon: Icon(Icons.list), onPressed: () => _scaffoldKey.currentState.openEndDrawer()),
              ]
            : <Widget>[
                IconButton(icon: Icon(Icons.arrow_left), onPressed: previousDay),
                IconButton(icon: Icon(Icons.sync), onPressed: () => sync(context)),
                IconButton(icon: Icon(Icons.restore), onPressed: resetDay),
                IconButton(icon: Icon(Icons.arrow_right), onPressed: nextDay),
              ],
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: PageView.builder(
              controller: pageController,
              reverse: true,
              itemBuilder: (context, offset) => CalendarDay(day: today.add(Duration(days: -offset)), showHeader: false),
              onPageChanged: handleDayChanged,
            ),
          ),
          Divider(),
          Flexible(
            flex: 1,
            child: PageView.builder(
              controller: weekPageController,
              reverse: true,
              itemBuilder: (context, offset) =>
                  (offset != 0) ? MiniWeekReport(start: sow, weeksAgo: -offset) : GoalsForTheWeek(),
              onPageChanged: (offset) {
                final sow = weekday + offset * 7;
                final nearestDayPage = pageController.page.clamp(sow - 6, sow);
                if (pageController.page != nearestDayPage)
                pageController.animateToPage(nearestDayPage,
                  duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
              },
            ),
          )
        ],
      ),
      endDrawer: DrawerOverlay(drawerContent: EventList(popOnNav: true)),
    );
  }
}
