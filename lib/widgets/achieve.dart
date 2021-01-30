import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:yaml/yaml.dart';

import '../db.dart';

class AchieveForm extends StatefulWidget {
  final String eventName;
  AchieveForm({Key key, this.eventName}) : super(key: key);

  @override
  AchieveFormState createState() => AchieveFormState(eventName);

  static void popup(BuildContext context, [String eventName]) {
    final _formKey = GlobalKey<AchieveFormState>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Achieve Task'),
        content: SingleChildScrollView(
          child: AchieveForm(key: _formKey, eventName: eventName),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Record'),
            onPressed: () => _formKey.currentState.save(context),
          ),
        ],
      ),
    );
  }
}

class AchieveFormState extends State<AchieveForm> {
  static final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  final _formKey = GlobalKey<FormState>();
  final _descriptionKey = GlobalKey();
  final TextEditingController descriptionController = TextEditingController();
  bool descriptionWasEdited = false;
  Map<String, dynamic> event;

  AchieveFormState(String name)
      : event = {
          'type': 'weekly goals',
          'name': name ?? '',
          'timestamp': DateTime.now(),
          'timezone': tz.local.name,
          'timezoneOffset': tz.local.currentTimeZone.offset ~/ 1000,
          'real_time': true,
        } {}

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
    final latest = (await _dbProvider.findLatestEvents('weekly goals', event['name'], 3)).map((e) => e.description).toList();
    if (latest.isEmpty || (latest.length == 1 && latest.first.isEmpty))
      descriptionController.text = '';
    else if (latest.length == 1)
      descriptionController.text = latest.first;
    else if ((!latest[0].isEmpty) && latest[0] == latest[1])
      descriptionController.text = latest.first;
    else if ((!latest[1].isEmpty) && latest[1] == latest[2])
      descriptionController.text = latest[1];
    else if ((!latest[0].isEmpty) && latest[0] == latest[2])
      descriptionController.text = latest.first;
    else descriptionController.text = '';
  }

  Widget goalPicker(BuildContext context) {
    final _dbProvider = Provider.of<WeeklyGoalsDatabase>(context);
    return StreamBuilder<List<Goal>>(
        stream: _dbProvider.watchCurrentGoals(),
        builder: (context, goalsSnapshot) {
          final currentGoals = goalsSnapshot.data ?? [];
          if (currentGoals.isEmpty) return Text('Loading…');
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
            value: event['name'].isEmpty ? null : event['name'],
            hint: Text('Select a goal'),
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

  void searchDescriptionPopup() async {
    final _dbProvider = Provider.of<WeeklyGoalsDatabase>(context);
    final descriptions = await _dbProvider.findEventDescriptions('weekly goals', event['name']);
    if (descriptions.length == 0 || (descriptions.length == 1 && descriptions.first.isEmpty)) {
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Nothing found'),
          content: Text('There are no descriptions for this goal in the database.'),
        ),
      );
      if (!descriptionWasEdited) descriptionController.text = '';
    } else if (descriptions.length == 1 && !descriptionWasEdited) {
      descriptionController.text = '';
    } else {
      final RenderBox row = _descriptionKey.currentContext.findRenderObject() as RenderBox;
      final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
      final RelativeRect position = RelativeRect.fromRect(
        Rect.fromPoints(
          row.localToGlobal(Offset.zero, ancestor: overlay),
          row.localToGlobal(row.size.bottomRight(Offset.zero), ancestor: overlay),
        ),
        Offset.zero & overlay.size,
      );
      final choice = await showMenu<String>(
        context: context,
        position: position,
        items: descriptions
            .map(
              (d) => PopupMenuItem<String>(
                value: d,
                child: d.isNotEmpty ? Text(d) : Text('(empty)', style: TextStyle(fontStyle: FontStyle.italic)),
              ),
            )
            .toList(),
      );
      if (choice != null) descriptionController.text = choice;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [
      Row(
        key: _descriptionKey,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              onSaved: (value) {
                setState(() {
                  event['description'] = value;
                });
              },
              maxLines: 5,
            ),
          ),
          Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => descriptionController.text = '',
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: searchDescriptionPopup,
              ),
            ],
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Text('Time: ${dateFormat.format(event['timestamp'])}'),
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
                // XXX temporary work-around for flutter/material's time picker dial
                // being UX-broken on 24h mode
                builder: (BuildContext context, Widget child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: false),
                    child: child,
                  );
                },
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
    ];

    if (widget.eventName == null) {
      widgets.insert(0, goalPicker(context));
    }

    return Form(
      key: _formKey,
      child: ListBody(
        children: widgets,
      ),
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
