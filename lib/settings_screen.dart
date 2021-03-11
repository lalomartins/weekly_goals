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
              CardSettingsText(label: 'Version', initialValue: packageInfo.version, enabled: false),
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
                label: 'Full Screen',
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
                label: 'Authentication Token',
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
