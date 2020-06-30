import 'package:flutter/material.dart';

class Config {
  int dayOffsetMinutes = 300;
  Duration get dayOffset => Duration(minutes: dayOffsetMinutes);
  int weekStartsOn = DateTime.sunday;
  String serverAddress = 'http://10.0.0.195';

  void init(BuildContext context) {
    weekStartsOn = MaterialLocalizations.of(context).firstDayOfWeekIndex;
  }
}

final config = Config();
