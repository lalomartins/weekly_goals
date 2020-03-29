import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';
import 'package:yaml/yaml.dart';

import 'db.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context).settings.arguments;
    return AddEventForm(event);
  }
  
}

class AddEventForm extends StatefulWidget {
  final Event event;

  AddEventForm([this.event]) : super();

  @override
  _AddEventFormState createState() => _AddEventFormState(event);
}

String validateNonEmpty(String value) {
  if (value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

class _AddEventFormState extends State<AddEventForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> event;

  _AddEventFormState(_event) {
    if (_event == null) {
      event = {
        'timestamp': DateTime.now(),
        'realtime': true,
      };
    } else {
      event = _event.toJson();
      event['id'] = null;
      event['timestamp'] = DateTime.now();
    }
  }

  Widget textField(String name,
      {String label, validator = validateNonEmpty, bool multiline = false}) {
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
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            textField('type'),
            textField('name'),
            textField('description', multiline: true, validator: null),
            CheckboxListTile(
              title: Text('Real time'),
              value: event['realTime'] ?? false,
              onChanged: (newValue) =>
                  setState(() => event['realTime'] = newValue),
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
                      initialTime: TimeOfDay.fromDateTime(
                          event['timestamp'] as DateTime),
                    );
                    if (selectedTime == null) return;

                    setState(() {
                      event['timestamp'] = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );
                    });
                  },
                ),
              ],
            ),
            textField('additional',
                multiline: true,
                validator: (String value) {
                  if (value.isEmpty) return null;
                  try {
                    var v = loadYaml(value);
                    if (v is Map) return null;
                    else return 'If additional data is provided, it must be a mapping';
                  } catch (e) {
                    return 'Invalid YAML';
                  }
                }),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                    try {
                      Provider.of<WeeklyGoalsDatabase>(context)
                          .createEventFromMap(event);
                      Navigator.pop(context);
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Recorded'),
                          backgroundColor: Theme.of(context).primaryColor));
                    } catch (e) {
                      print(e);
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Failed to record'),
                          backgroundColor: Theme.of(context).errorColor));
                    }
                  }
                },
                child: Text('Record'),
              ),
            ),
          ],
        ));
  }
}
