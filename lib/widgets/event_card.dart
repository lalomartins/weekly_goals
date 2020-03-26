import 'dart:ui';

import 'package:flutter/material.dart';

import '../db.dart';

class EventCard extends StatefulWidget {
  EventCard({
    @required this.event,
    this.onNav,
  }) : super(key: ObjectKey(event.id));

  final Event event;
  final void Function() onNav;

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () => setState(() => expand = !expand),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                            Text.rich(TextSpan(text: '', children: [
                              TextSpan(
                                  text: widget.event.type,
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: '/', style: TextStyle(fontSize: 8)),
                              TextSpan(
                                  text: widget.event.name,
                                  style: TextStyle(fontSize: 18)),
                            ])),
                            Text(
                                widget.event.timestamp.toString() +
                                    (widget.event.realTime
                                        ? ' (real time)'
                                        : ''),
                                style: TextStyle(
                                    fontSize: 10, fontStyle: FontStyle.italic)),
                            Text(
                              widget.event.description,
                              softWrap: true,
                              maxLines: expand ? null : 1,
                              overflow: TextOverflow.fade,
                            ),
                          ] +
                          (widget.event.additional == null
                              ? []
                              : [
                                  Divider(),
                                  Text(widget.event.additional,
                                      softWrap: true,
                                      maxLines: expand ? null : 2,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Roboto Mono')),
                                ])),
                )),
            Container(
              width: 45,
              child: FlatButton(
                child: Icon(
                  Icons.content_copy,
                  size: 32.0,
                ),
                onPressed: () {
                  if (widget.onNav != null) widget.onNav();
                  Navigator.pushNamed(
                    context,
                    'add',
                    arguments: widget.event,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
