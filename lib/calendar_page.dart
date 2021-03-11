import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weekly_goals/drawer_menu.dart';

import 'widgets/achieve.dart';
import 'date_util.dart';
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
  PageController pageController;
  DateTime thisWeek;
  Timer _updaterTimer;
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    pageController = PageController();
    super.initState();
    thisWeek = startOfWeek();
    _updaterTimer = new Timer.periodic(Duration(minutes: 1), (Timer t) {
      final newWeek = startOfWeek();
      if (newWeek.isAfter(thisWeek))
        setState(() {
          thisWeek = newWeek;
        });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    _updaterTimer.cancel();
    super.dispose();
  }

  void previousWeek() {
    setState(() {
      pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  void nextWeek() {
    setState(() {
      pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  void resetWeek() {
    setState(() {
      pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sow = thisWeek.add(Duration(days: weekOffset * 7));
    final eow = sow.add(Duration(days: 6));
    String weekFormatted;
    // Eventually we want to use local formats, but for now since I like it it Japanese,
    // until I add a locale override feature or something, I'll hardcode it
    if (sow.year != eow.year)
      weekFormatted = '${sow.year}年${sow.month}月${sow.day} — ${eow.year}年${eow.month}月${eow.day}日';
    else if (sow.month != eow.month)
      weekFormatted = '${sow.year}年${sow.month}月${sow.day}日 — ${eow.month}月${eow.day}日';
    else
      weekFormatted = '${sow.year}年${sow.month}月${sow.day} — ${eow.day}日';
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Week of ' + weekFormatted),
        actions: weekOffset == 0
            ? <Widget>[
                IconButton(icon: Icon(Icons.arrow_left), onPressed: previousWeek),
                IconButton(icon: Icon(Icons.check_circle_outline), onPressed: () => AchieveForm.popup(context)),
              ]
            : <Widget>[
                IconButton(icon: Icon(Icons.arrow_left), onPressed: previousWeek),
                IconButton(icon: Icon(Icons.restore), onPressed: resetWeek),
                IconButton(icon: Icon(Icons.arrow_right), onPressed: nextWeek),
              ],
      ),
      body: PageView.builder(
        controller: pageController,
        reverse: true,
        itemBuilder: (context, offset) =>
            Calendar(start: thisWeek.subtract(Duration(days: offset * 7)), weeksAgo: offset),
        onPageChanged: (offset) => setState(() => weekOffset = -offset),
      ),
      drawer: DrawerOverlay(drawerContent: DrawerMenu(current: weekOffset == 0)),
    );
  }
}
