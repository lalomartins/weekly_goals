import 'package:clean_settings/clean_settings.dart';
import 'package:flutter/material.dart';

class SettingTimeItem extends StatelessWidget {
  final String title;
  final String displayValue;
  final TimeOfDay initialTime;

  final ValueChanged<TimeOfDay> onChanged;
  final ItemPriority priority;

  SettingTimeItem(
      {Key key,
      @required this.title,
      @required this.onChanged,
      this.displayValue,
      this.initialTime,
      this.priority = ItemPriority.normal})
      : super(key: key) {
  }

  @override
  Widget build(BuildContext context) {
    return SettingItem(
      title: title,
      priority: priority,
      displayValue: displayValue ?? initialTime.format(context),
      onTap: () async {
        final todPicked = await showTimePicker(
          context: context,
          initialTime: initialTime ?? TimeOfDay.now(),
        );

        if (todPicked != null)
          onChanged(todPicked);
      });
  }
}
