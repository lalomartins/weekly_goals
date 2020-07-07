import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:yaml/yaml.dart';

import 'db.dart';
import 'widgets/event_editor_state.dart';

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

class _EditEventFormState extends EventEditorState<EditEventForm> {
  final _formKey = GlobalKey<FormState>();

  _EditEventFormState(_event) {
    event = _event.toJson();
    event['timestamp'] = _event.timestamp;
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
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () => delete(context),
                      child: Text('Delete', style: TextStyle(color: Theme.of(context).colorScheme.onError)),
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 10.0)),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () => save(context),
                      child: Text('Update'),
                    ),
                  ),
                ],
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
        final data = event.map((k, v) => MapEntry(k, v));
        data['timestamp'] = event['timestamp'].millisecondsSinceEpoch;
        await Provider.of<WeeklyGoalsDatabase>(context).updateEvent(Event.fromJson(data));
        savingBar.dismiss();
        Navigator.pop(context);
        Flushbar(
          message: 'Updated',
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.save, color: Theme.of(context).colorScheme.onPrimary),
          duration: Duration(seconds: 30),
        )..show(context);
      } catch (e) {
        savingBar.dismiss();
        print(e);
        Flushbar(
          message: 'Failed to update',
          backgroundColor: Theme.of(context).errorColor,
          icon: Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
          duration: Duration(seconds: 60),
        )..show(context);
      }
    }
  }

  delete(BuildContext context) async {
    final deletingBar = Flushbar(
      message: 'Deleting event…',
      backgroundColor: Theme.of(context).primaryColor,
    )..show(context);
    final savedEvent = widget.event;
    try {
      await Provider.of<WeeklyGoalsDatabase>(context).deleteEvent(widget.event.uuid);
      deletingBar.dismiss();
      Navigator.pop(context);
      Flushbar(
        message: 'Deleted',
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.onPrimary),
        mainButton: _RestoreButton(message: 'undo', savedEvent: savedEvent),
        duration: Duration(seconds: 60),
      )..show(context);
    } catch (e) {
      deletingBar.dismiss();
      print(e);
      Flushbar(
        message: 'Failed to delete',
        backgroundColor: Theme.of(context).errorColor,
        icon: Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
        duration: Duration(seconds: 60),
      )..show(context);
    }
  }
}

class _RestoreButton extends StatelessWidget {
  const _RestoreButton({
    Key key,
    @required this.message,
    @required this.savedEvent,
  }) : super(key: key);

  final String message;
  final Event savedEvent;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(message, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      onPressed: () => restore(context),
    );
  }

  restore(BuildContext context) async {
    final parent = context.findAncestorWidgetOfExactType<Flushbar>();
    if (parent != null) parent.dismiss();
    final restoringBar = Flushbar(
      message: 'Restoring event…',
      backgroundColor: Theme.of(context).primaryColor,
    )..show(context);
    try {
      await Provider.of<WeeklyGoalsDatabase>(context).createEventFromMap(savedEvent.toJson());
      restoringBar.dismiss();
      Flushbar(
        message: 'Restored',
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.undo, color: Theme.of(context).colorScheme.onPrimary),
        duration: Duration(seconds: 30),
      ).show(context);
    } catch (e) {
      restoringBar.dismiss();
      print(e);
      Flushbar(
        message: 'Failed to restore event',
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
        mainButton: _RestoreButton(message: 'retry', savedEvent: savedEvent),
        duration: Duration(seconds: 60),
      )..show(context);
    }
  }
}
