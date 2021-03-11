import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'config.dart';
import 'db.dart';
import 'server_client.dart';

class DrawerMenu extends StatelessWidget {
  final bool primary;
  final bool current;

  DrawerMenu({this.primary = false, this.current = false});

  void sync(BuildContext context) {
    Navigator.pop(context);
    final syncingBar = Flushbar(
      message: 'Sync in progress',
      backgroundColor: Theme.of(context).primaryColor,
    )..show(context);
    final scaffold = Scaffold.of(context);

    Timer(Duration(milliseconds: 250), () async {
      final context = scaffold.context;
      final db = Provider.of<WeeklyGoalsDatabase>(context);
      final client = Provider.of<ServerClient>(context);
      try {
        await client.sync(db);
        syncingBar.dismiss();
        Flushbar(
          message: 'Sync completed',
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.sync, color: Theme.of(context).colorScheme.onPrimary),
          duration: Duration(seconds: 30),
        )..show(context);
      } catch (e) {
        syncingBar.dismiss();
        print('Sync error!');
        print(e);
        Flushbar errorBar;
        errorBar = Flushbar(
          message: 'Sync error. Try again later, or check the logs.',
          backgroundColor: Theme.of(context).errorColor,
          icon: Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
          mainButton: FlatButton(
            child: Text('dismiss', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
            onPressed: () => errorBar.dismiss(),
          ),
          duration: Duration(seconds: 60),
        )..show(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final packageInfo = Provider.of<PackageInfo>(context);

    return ListView(
      primary: primary,
      children: [
        ListTile(
          title: Text('Weekly Goals'),
          subtitle: Text('version ${packageInfo.version}'),
          tileColor: Theme.of(context).primaryColor,
        ),
        ListTile(
          title: Text('Sync to cloud'),
          subtitle: Text('Warning: work in progress, very slow'),
          enabled: config.serverAddress.isNotEmpty && config.serverAccount.isNotEmpty && config.serverToken.isNotEmpty,
          leading: Icon(Icons.sync),
          onTap: () => sync(context),
        ),
        ListTile(
          title: Text('Raw event log'),
          subtitle: Text('Warning: mainly for development purposes'),
          leading: Icon(Icons.list_alt),
          onTap: () => Navigator.pushNamed(context, 'events'),
        ),
        ListTile(
          title: Text('Settings'),
          leading: Icon(Icons.settings),
          onTap: () => Navigator.pushNamed(context, 'settings'),
        ),
      ],
    );
  }
}
