import 'package:flutter/material.dart';

class Config {
  int dayOffsetMinutes = 300;
  int weekStartsOn = DateTime.sunday;

  void init(BuildContext context) {
    weekStartsOn = MaterialLocalizations.of(context).firstDayOfWeekIndex;
  }
}

final config = Config();
