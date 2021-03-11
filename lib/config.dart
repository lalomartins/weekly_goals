import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config with ChangeNotifier {
  SharedPreferences _preferences;

  int _dayOffsetMinutes = 300;
  int get dayOffsetMinutes => _dayOffsetMinutes;
  set dayOffsetMinutes(int dayOffsetMinutes) {
    _dayOffsetMinutes = dayOffsetMinutes;
    _preferences.setInt('dayOffsetMinutes', dayOffsetMinutes);
    notifyListeners();
  }
  Duration get dayOffset => Duration(minutes: dayOffsetMinutes);

  int _weekStartsOn = DateTime.sunday;
  int get weekStartsOn => _weekStartsOn;
  set weekStartsOn(int weekStartsOn) {
    _weekStartsOn = weekStartsOn;
    _preferences.setInt('weekStartsOn', weekStartsOn);
    notifyListeners();
  }

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    _preferences.setString('themeMode', themeMode.toString());
    notifyListeners();
  }

  String _serverAddress = 'http://example.com/';
  String get serverAddress => _serverAddress;
  set serverAddress(String serverAddress) {
    _serverAddress = serverAddress;
    _preferences.setString('serverAddress', serverAddress);
    notifyListeners();
  }

  String _serverAccount = '';
  String get serverAccount => _serverAccount;
  set serverAccount(String serverAccount) {
    _serverAccount = serverAccount;
    _preferences.setString('serverAccount', serverAccount);
    notifyListeners();
  }

  String _serverToken = '';
  String get serverToken => _serverToken;
  set serverToken(String serverToken) {
    _serverToken = serverToken;
    _preferences.setString('serverToken', serverToken);
    notifyListeners();
  }

  Future<void> load() async {
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.containsKey('dayOffsetMinutes')) _dayOffsetMinutes = _preferences.getInt('dayOffsetMinutes');
    if (_preferences.containsKey('weekStartsOn')) _weekStartsOn = _preferences.getInt('weekStartsOn');
    if (_preferences.containsKey('themeMode')) {
      setThemeMode(_preferences.getString('themeMode'));
    }
    if (_preferences.containsKey('serverAddress')) _serverAddress = _preferences.getString('serverAddress');
    if (_preferences.containsKey('serverAccount')) _serverAccount = _preferences.getString('serverAccount');
    if (_preferences.containsKey('serverToken')) _serverToken = _preferences.getString('serverToken');
  }

  void setThemeMode(String themeMode, [bool save = true]) {
    switch (themeMode) {
      case 'ThemeMode.dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'ThemeMode.light':
        _themeMode = ThemeMode.light;
        break;
      default:
        _themeMode = ThemeMode.system;
    }
    if (save)
      _preferences.setString('themeMode', _themeMode.toString());
      notifyListeners();
  }

  void useLocaleDefaults(BuildContext context) {
    if (!_preferences.containsKey('weekStartsOn'))
      _weekStartsOn = MaterialLocalizations.of(context).firstDayOfWeekIndex;
      notifyListeners();
  }
}

final config = Config();
