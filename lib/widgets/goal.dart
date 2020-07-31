import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

import 'achieve.dart';
import '../model/goal.dart';
import 'section_title.dart';
import '../db.dart';

class GoalInfo extends StatefulWidget {
  final Goal goal;
  GoalInfo({Key key, this.goal}) : super(key: key);

  @override
  _GoalInfoState createState() => _GoalInfoState();

  static void popup(BuildContext context, Goal goal) {
    final _formKey = GlobalKey<_GoalInfoState>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Goal'),
        content: SingleChildScrollView(
          child: GoalInfo(key: _formKey, goal: goal),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            onPressed: () => _formKey.currentState.save(context),
          ),
        ],
      ),
    );
  }
}

class _GoalInfoState extends State<GoalInfo> {
  bool editMode = false;
  final _achieveFormKey = GlobalKey<AchieveFormState>();

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Name: '),
                    Text(widget.goal.name),
                  ],
                ),
                Row(
                  children: [
                    Text('Category: '),
                    Text(widget.goal.category),
                  ],
                ),
              ],
            ),
            Spacer(),
            IconButton(icon: Icon(Icons.edit), onPressed: () => interimChangeForm(context)),
          ],
        ),
        SectionTitle.h(5, 'Achieve'),
        AchieveForm(key: _achieveFormKey, eventName: widget.goal.name),
      ],
    );
  }

  void interimChangeForm(BuildContext context) {
    final now = DateTime.now();
    final template = Event(
      uuid: null,
      type: 'set goal',
      name: widget.goal.name,
      description: 'Change weekly goal',
      timestamp: now,
      timezone: tz.local.name,
      timezoneOffset: tz.local.currentTimeZone.offset ~/ 1000,
      realTime: true,
      additional: '''
category: "${widget.goal.category}"
name: "${widget.goal.name}"
notes: ""
perWeek: ${widget.goal.perWeek}
dailyAmountMatters: ${widget.goal.dailyAmountMatters}
immediate: true
      ''',
    );
    Navigator.pushNamed(
      context,
      'add',
      arguments: template,
    );
  }

  void save(BuildContext context) {
    if (editMode) {
      //
    } else {
      _achieveFormKey.currentState.save(context);
    }
  }
}
