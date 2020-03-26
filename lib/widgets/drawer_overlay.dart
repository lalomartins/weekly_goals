import 'package:flutter/material.dart';

class DrawerOverlay extends StatelessWidget {
  final Widget drawerContent;

  const DrawerOverlay({
    Key key,
    @required this.drawerContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
        ),
        child: drawerContent,
      ),
    );
  }
}
