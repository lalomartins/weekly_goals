
import 'package:flutter/material.dart';

import 'package:clean_settings_nnbd/clean_settings_nnbd.dart';
// import 'package:clean_settings/clean_settings.dart';

/// Wrap SettingRadioItem to calculate displayValue automatically
class SettingRadioItemSmart<T> extends StatelessWidget {
  final String title;
  final T selectedValue;

  final List<SettingRadioValue<T>> items;
  final ValueChanged<T> onChanged;
  final String cancelText;
  final ItemPriority priority;

  const SettingRadioItemSmart({
    Key key,
    @required this.title,
    @required this.items,
    @required this.onChanged,
    this.selectedValue,
    this.cancelText,
    this.priority = ItemPriority.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var displayValue = '';
    for (final item in items) {
      if (item.value == selectedValue)
        displayValue = item.title;
    }

    return SettingRadioItem<T>(
      key: key,
      title: title,
      items: items,
      onChanged: onChanged,
      selectedValue: selectedValue,
      displayValue: displayValue,
      cancelText: cancelText,
      priority: priority,
    );
  }
}
