import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'db.dart';
import 'widgets/event_card.dart';

class EventList extends StatelessWidget {
  final bool primary;
  final bool popOnNav;

  EventList({this.primary = false, this.popOnNav = false});

  @override
  Widget build(BuildContext context) {
    final _dbProvider = Provider.of<EventDatabase>(context);

    return StreamBuilder<List<Event>>(
        stream: _dbProvider.watchRecentEvents(days: 7),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }

          final events = snapshot.data;

          return ListView.builder(
            primary: primary,
            itemCount: events.length,
            itemBuilder: (context, index) => EventCard(event: events[index], onNav: popOnNav ? () {Navigator.pop(context);} : null),
          );
        });
  }
}
