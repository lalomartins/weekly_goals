import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:yaml/yaml.dart';

import 'db.dart';
import 'widgets/event_editor_state.dart';

class AddScreen extends StatelessWidget {
  final _formKey = GlobalKey<_AddEventFormState>();

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Event'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.check), onPressed: save),
          ],
        ),
        body: AddEventForm(key: _formKey, event: event));
  }

  void save() => _formKey.currentState?.save(_formKey.currentContext);
}

class AddEventForm extends StatefulWidget {
  final Event event;

  AddEventForm({Key key, this.event}) : super(key: key);

  @override
  _AddEventFormState createState() => _AddEventFormState(event);
}

class _AddEventFormState extends EventEditorState<AddEventForm> {
  final _formKey = GlobalKey<FormState>();

  _AddEventFormState(_event) {
    final now = DateTime.now();
    if (_event == null) {
      event = {
        'timestamp': now,
        'timezone': tz.local.name,
        'timezoneOffset': tz.local.currentTimeZone.offset ~/ 1000,
        'real_time': true,
      };
    } else {
      event = _event.toJson();
      event['uuid'] = null;
      event['synced'] = null;
      event['timestamp'] = now;
      event['timezone'] = tz.local.name;
      event['timezoneOffset'] = tz.local.currentTimeZone.offset ~/ 1000;
    }
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
            yamlField('additional', multiline: true),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              child: RaisedButton(
                onPressed: () => save(context),
                child: Text('Record'),
              ),
            ),
          ],
        ));
  }

  save(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final savingBar = Flushbar(
        message: 'Processing Data',
        backgroundColor: Theme.of(context).primaryColor,
      )..show(context);
      try {
        final db = Provider.of<WeeklyGoalsDatabase>(context);
        await db.createEventFromMap(event);
        if (event['type'] == 'set goal') await db.refreshGoals();
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
