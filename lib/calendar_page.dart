import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'achieve_dialog.dart';
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
  PageController pageController;
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
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

  @override
  Widget build(BuildContext context) {
    final thisWeek = startOfWeek();
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
                IconButton(icon: Icon(Icons.check_circle_outline), onPressed: () => AchieveDialog.popup(context)),
                IconButton(icon: Icon(Icons.sync), onPressed: () => sync(context)),
                IconButton(icon: Icon(Icons.list), onPressed: () => _scaffoldKey.currentState.openEndDrawer()),
              ]
            : <Widget>[
                IconButton(icon: Icon(Icons.arrow_left), onPressed: previousWeek),
                IconButton(icon: Icon(Icons.sync), onPressed: () => sync(context)),
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
      endDrawer: DrawerOverlay(drawerContent: EventList(popOnNav: true)),
    );
  }
}
