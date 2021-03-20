import 'package:flutter/material.dart';

import 'package:clean_settings_nnbd/clean_settings_nnbd.dart';
// import 'package:clean_settings/clean_settings.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'config.dart';
import 'widgets/setting_radio_item_smart.dart';
import 'widgets/setting_time_item.dart';

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
      builder: (_, packageInfo, __) => SettingContainer(
        sections: [
          SettingSection(
            items: [
              SettingTimeItem(
                title: 'Day start',
                initialTime: config.dayStartTime,
                onChanged: (value) => config.dayStartTime = value,
              ),
              SettingRadioItemSmart<int>(
                title: 'Week start',
                items: [
                  SettingRadioValue('Sunday', 1),
                  SettingRadioValue('Monday', 2),
                  SettingRadioValue('Tuesday', 3),
                  SettingRadioValue('Wednesday', 4),
                  SettingRadioValue('Thursday', 5),
                  SettingRadioValue('Friday', 6),
                  SettingRadioValue('Saturday', 0)
                ],
                selectedValue: config.weekStartsOn,
                onChanged: (value) => config.weekStartsOn = value,
              ),
            ],
          ),
          SettingSection(
            title: 'Appearance',
            items: [
              SettingRadioItemSmart<String>(
                title: 'Theme',
                items: [
                  SettingRadioValue('System Default', 'ThemeMode.system'),
                  SettingRadioValue('Dark', 'ThemeMode.dark'),
                  SettingRadioValue('Light', 'ThemeMode.light')
                ],
                selectedValue: config.themeMode.toString(),
                onChanged: config.setThemeMode,
              ),
              SettingSwitchItem(
                title: 'Full screen',
                value: config.fullscreen,
                onChanged: (value) => config.fullscreen = value,
                description:
                    'If this is enabled but the app is not fullscreen, try going to the app switcher, and switching back here.',
              ),
            ],
          ),
          SettingSection(
            title: 'Server',
            items: [
              SettingTextItem(
                title: 'Address',
                initialValue: config.serverAddress,
                displayValue: config.serverAddress,
                onChanged: (value) {
                  config.serverAddress = value;
                },
              ),
              SettingTextItem(
                title: 'Account',
                initialValue: config.serverAccount,
                displayValue: config.serverAccount,
                onChanged: (value) {
                  config.serverAccount = value;
                },
              ),
              SettingTextItem(
                title: 'Authentication token',
                initialValue: config.serverToken,
                displayValue: '·' * (config.serverToken?.length ?? 0),
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
