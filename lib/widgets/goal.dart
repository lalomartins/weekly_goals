import 'package:flutter/material.dart';
import 'package:weekly_goals/achieve.dart';
import 'package:weekly_goals/model/goal.dart';
import 'package:weekly_goals/widgets/section_title.dart';

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
        SectionTitle.h(5, 'Achieve'),
        AchieveForm(key: _achieveFormKey, eventName: widget.goal.name),
      ],
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
