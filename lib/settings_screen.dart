import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'config.dart';

class SettingsScreen extends StatelessWidget {
  final _formKey = GlobalKey<_SettingsFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Settings')), body: SettingsForm(key: _formKey));
  }
}

class SettingsForm extends StatefulWidget {
  SettingsForm({Key key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
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
            ],
          ),
        ],
      ),
    ));
  }
}
