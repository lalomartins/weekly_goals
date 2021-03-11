import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'config.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Settings')), body: SettingsForm());
  }
}

class SettingsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Consumer<PackageInfo>(
      builder: (_, packageInfo, __) => CardSettings.sectioned(
        showMaterialonIOS: true,
        children: [
          CardSettingsSection(
            header: CardSettingsHeader(label: 'General'),
            children: [
              CardSettingsTimePicker(
                label: 'Day start',
                initialValue: config.dayStartTime,
                icon: Icon(Icons.bedtime),
                onChanged: (value) => config.dayStartTime = value,
              ),
              CardSettingsSelectionPicker(
                label: 'Week start',
                options: [
                  'Sunday',
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                ],
                values: ['1', '2', '3', '4', '5', '6', '0'],
                initialValue: config.weekStartsOn.toString(),
                onChanged: (value) => config.weekStartsOn = int.parse(value),
              ),
            ],
          ),
          CardSettingsSection(
            header: CardSettingsHeader(label: 'Appearance'),
            children: [
              CardSettingsSelectionPicker(
                label: 'Theme',
                options: [
                  'System Default',
                  'Dark',
                  'Light',
                ],
                values: ['ThemeMode.system', 'ThemeMode.dark', 'ThemeMode.light'],
                initialValue: config.themeMode.toString(),
                onChanged: config.setThemeMode,
              ),
              CardSettingsSwitch(
                label: 'Full screen',
                initialValue: config.fullscreen,
                onChanged: (value) => config.fullscreen = value,
              ),
            ],
          ),
          CardSettingsSection(
            header: CardSettingsHeader(label: 'Server'),
            children: [
              CardSettingsText(
                label: 'Address',
                initialValue: config.serverAddress,
                maxLength: 255,
                autocorrect: false,
                onChanged: (value) {
                  config.serverAddress = value;
                },
              ),
              CardSettingsText(
                label: 'Account',
                initialValue: config.serverAccount,
                maxLength: 255,
                autocorrect: false,
                onChanged: (value) {
                  config.serverAccount = value;
                },
              ),
              CardSettingsText(
                label: 'Authentication token',
                initialValue: config.serverToken,
                maxLength: 255,
                autocorrect: false,
                onChanged: (value) {
                  config.serverToken = value;
                },
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
