import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weekly_goals/drawer_menu.dart';

import 'config.dart';
import 'widgets/achieve.dart';
import 'date_util.dart';
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
  DateTime today;
  Timer _updaterTimer;
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int _dayStart, _weekStart;

  @override
  void initState() {
    pageController = PageController();
    weekPageController = PageController();
    super.initState();
    today = date();
    _updaterTimer = new Timer.periodic(Duration(minutes: 1), (Timer t) {
      final newDay = date();
      if (newDay.isAfter(today))
        setState(() {
          today = newDay;
        });
    });
    _dayStart = config.dayOffsetMinutes;
    _weekStart = config.weekStartsOn;
    config.addListener(configListener);
  }

  void configListener() {
    if (_dayStart != config.dayOffset || _weekStart != config.weekStartsOn) {
      _dayStart = config.dayOffsetMinutes;
      _weekStart = config.weekStartsOn;
      setState(() {
        today = date();
      });
    }
  }

  @override
  void dispose() { 
    pageController.dispose();
    weekPageController.dispose();
    _updaterTimer.cancel();
    config.removeListener(configListener);
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

  void handleDayChanged(offset) {
    setState(() => dayOffset = -offset);
    final weekday = weekOffset(date());
    final weeks = ((weekday + dayOffset) / 7).floor();
    if (weekPageController.page != -weeks)
      weekPageController.animateToPage(-weeks, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
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
              ]
            : <Widget>[
                IconButton(icon: Icon(Icons.arrow_left), onPressed: previousDay),
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
      drawer: DrawerOverlay(drawerContent: DrawerMenu()),
    );
  }
}
