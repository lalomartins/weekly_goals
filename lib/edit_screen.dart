import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:yaml/yaml.dart';

import 'add_screen.dart';
import 'db.dart';

class EditScreen extends StatelessWidget {
  final _formKey = GlobalKey<_EditEventFormState>();

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Event'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.check), onPressed: save),
          ],
        ),
        body: EditEventForm(key: _formKey, event: event));
  }

  void save() => _formKey.currentState?.save(_formKey.currentContext);
}

class EditEventForm extends StatefulWidget {
  final Event event;

  EditEventForm({Key key, this.event}) : super(key: key);

  @override
  _EditEventFormState createState() => _EditEventFormState(event);
}

class _EditEventFormState extends State<EditEventForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> event;

  _EditEventFormState(_event) {
    event = _event.toJson();
    event['timestamp'] = _event.timestamp;
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
              value: event['real_time'] ?? false,
              onChanged: (newValue) =>
                  setState(() => event['real_time'] = newValue),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              child: RaisedButton(
                onPressed: () => save(context),
                child: Text('Update'),
              ),
            ),
          ],
        ));
  }

  save(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
      try {
        final data = event.map((k, v) => MapEntry(k, v));
        data['timestamp'] = event['timestamp'].millisecondsSinceEpoch;
        Provider.of<WeeklyGoalsDatabase>(context).updateEvent(Event.fromJson(data));
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Updated'),
            backgroundColor: Theme.of(context).primaryColor));
      } catch (e) {
        print(e);
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Failed to update'),
            backgroundColor: Theme.of(context).errorColor));
      }
    }
  }
}
