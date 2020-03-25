import 'package:flutter/material.dart';

const _defaultPadding = EdgeInsets.only(left: 8.0, bottom: 8.0, top: 16.0);

class SectionTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;
  final TextStyle style;

  SectionTitle(this.title, {this.padding = _defaultPadding, this.style});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding,
      child: Text(
        title,
        style: style ??
            TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
