import 'dart:math';

import 'package:flutter/material.dart';

class DrawerOverlay extends StatelessWidget {
  final Widget drawerContent;

  const DrawerOverlay({
    Key key,
    @required this.drawerContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: min(400, mq.size.width * .8)),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
        ),
        child: drawerContent,
      ),
    );
  }
}
