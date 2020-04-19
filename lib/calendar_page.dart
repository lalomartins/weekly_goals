import 'package:flutter/material.dart';

import 'date_util.dart';
import 'event_list.dart';
import 'widgets/calendar.dart';
import 'widgets/drawer_overlay.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sow = startOfWeek();
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
      appBar: AppBar(
        title: Text('Week of ' + weekFormatted),
      ),
      body: Calendar(start: sow),
      endDrawer: DrawerOverlay(drawerContent: EventList(popOnNav: true)),
    );
  }
}
