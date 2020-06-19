import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';
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
  Map<String, dynamic> event;

  _AchieveDialogState(String name)
      : event = {
          'type': 'weekly goals',
          'name': name,
          'timestamp': DateTime.now(),
          'timezone': tz.local.name,
          'timezoneOffset': tz.local.currentTimeZone.offset ~/ 1000,
          'real_time': true,
        } {}

  Widget textField(String name, {String label, validator, bool multiline = false}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label ?? capitalize(name)),
      initialValue: event[name] ?? '',
      onSaved: (value) {
        setState(() {
          event[name] = value;
        });
      },
      validator: validator,
      maxLines: multiline ? 5 : 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Achieve Task'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: ListBody(
            children: <Widget>[
              textField('name'),
              textField('description', multiline: true, validator: null),
              CheckboxListTile(
                title: Text('Real time'),
                value: event['real_time'] ?? false,
                onChanged: (newValue) => setState(() => event['real_time'] = newValue),
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
              textField('additional', multiline: true, validator: (String value) {
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
              }),
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
