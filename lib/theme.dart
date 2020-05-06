import 'package:flutter/material.dart';

final wgLightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.green,
);

final wgDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.green,
  primaryColor: Color.lerp(wgLightTheme.primaryColor, Colors.black, 0.3),
  primaryColorDark: Color.lerp(wgLightTheme.primaryColor, Colors.black, 0.5),
);
