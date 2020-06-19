import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:yaml/yaml.dart';

import 'db.dart';

class AchieveDialog extends StatefulWidget {
  final String eventName;
  AchieveDialog({Key key, this.eventName}) : super(key: key);

  @override
  _AchieveDialogState createState() => _AchieveDialogState(eventName);

  static void popup(BuildContext context, [String eventName]) {
    showDialog(
      context: context,
      builder: (context) => AchieveDialog(eventName: eventName),
    );
  }
}

class _AchieveDialogState extends State<AchieveDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  bool descriptionWasEdited = false;
  Map<String, dynamic> event;

  _AchieveDialogState(String name) :
    event = {
      'type': 'weekly goals',
      'name': name ?? '',
      'timestamp': DateTime.now(),
      'timezone': tz.local.name,
      'timezoneOffset': tz.local.currentTimeZone.offset ~/ 1000,
      'real_time': true,
    }
  {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autoDescription();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void autoDescription() async {
    if (descriptionWasEdited || event['name'].isEmpty) return;
    final _dbProvider = Provider.of<WeeklyGoalsDatabase>(context);
    final latest = await _dbProvider.findLatestEvent('weekly goals', event['name']);
    setState(() {
      if (latest == null)
        event['description'] = '';
      else
        event['description'] = latest.description;
      descriptionController.text = event['description'];
    });
  }

  Widget goalPicker(BuildContext context) {
    final _dbProvider = Provider.of<WeeklyGoalsDatabase>(context);
    return StreamBuilder<List<Goal>>(
        stream: _dbProvider.watchCurrentGoals(),
        builder: (context, goalsSnapshot) {
          final currentGoals = goalsSnapshot.data ?? [];
          final sortedGoals = Goal.sortByCategory(currentGoals);
          List<DropdownMenuItem<String>> items = [];
          List<Widget> selected = [];
          for (final category in sortedGoals.keys) {
            final first = sortedGoals[category].first;
            items.add(DropdownMenuItem<String>(
              value: first.name,
              child: Text.rich(TextSpan(text: '', children: [
                TextSpan(text: category, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                TextSpan(text: '/', style: TextStyle(fontSize: 12)),
                TextSpan(text: first.name, style: TextStyle(fontSize: 18)),
              ])),
            ));
            items.addAll(
              sortedGoals[category].sublist(1).map(
                    (goal) => DropdownMenuItem<String>(
                      value: goal.name,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(goal.name),
                      ),
                    ),
                  ),
            );
            selected.addAll(
              sortedGoals[category].map((goal) => Text('$category/${goal.name}')),
            );
          }

          return DropdownButtonFormField<String>(
            value: event['name'],
            validator: (value) => value.isEmpty ? 'Select a goal' : null,
            items: items,
            selectedItemBuilder: (context) => selected,
            onChanged: (value) {
              setState(() {
                event['name'] = value;
              });
              autoDescription();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print('build; description is ${event["description"]}');
    return AlertDialog(
      title: Text('Achieve Task'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: ListBody(
            children: <Widget>[
              goalPicker(context),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  setState(() {
                    event['description'] = value;
                  });
                },
                maxLines: 5,
              ),
              Row(
                children: <Widget>[
                  Text('Time: ${(event['timestamp'] as DateTime).toString()}'),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: event['timestamp'] as DateTime,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(3000),
                      );
                      if (selectedDate == null) return;

                      final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(event['timestamp'] as DateTime),
                      );
                      if (selectedTime == null) return;

                      setState(() {
                        final dt = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                        event['timestamp'] = dt;
                        event['timezone'] = tz.local.name;
                        event['timezoneOffset'] = tz.local.timeZone(dt.millisecondsSinceEpoch).offset ~/ 1000;
                      });
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Advanced'),
                backgroundColor: Colors.grey.withOpacity(.25),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Additional'),
                      initialValue: event['additional'] ?? '',
                      onSaved: (value) {
                        setState(() {
                          event['additional'] = value;
                        });
                      },
                      validator: (String value) {
                      if (value.isEmpty) return null;
                      try {
                        var v = loadYaml(value);
                        if (v is Map)
                          return null;
                        else
                          return 'If additional data is provided, it must be a mapping';
                      } catch (e) {
                        return 'Invalid YAML';
                      }
                    },
                      maxLines: 5,
                    ),
                  ),
                  CheckboxListTile(
                    title: Text('Real time'),
                    value: event['real_time'] ?? false,
                    onChanged: (newValue) => setState(() => event['real_time'] = newValue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Record'),
          onPressed: () => save(context),
        ),
      ],
    );
  }

  save(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final savingBar = Flushbar(
        message: 'Processing Data',
        backgroundColor: Theme.of(context).primaryColor,
      )..show(context);
      try {
        await Provider.of<WeeklyGoalsDatabase>(context).createEventFromMap(event);
        savingBar.dismiss();
        Navigator.pop(context);
        Flushbar(
          message: 'Recorded',
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.save, color: Theme.of(context).colorScheme.onPrimary),
          duration: Duration(seconds: 30),
        )..show(context);
      } catch (e) {
        savingBar.dismiss();
        print(e);
        Flushbar(
          message: 'Failed to record',
          backgroundColor: Theme.of(context).errorColor,
          icon: Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
          duration: Duration(seconds: 60),
        )..show(context);
      }
    }
  }
}
