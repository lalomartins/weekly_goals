import 'package:flutter/material.dart';

const _defaultPadding = EdgeInsets.only(left: 8.0, bottom: 8.0, top: 16.0);

class SectionTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;
  final TextStyle style;
  final TextAlign textAlign;

  SectionTitle(this.title, {this.padding = _defaultPadding, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding,
      child: Text(
        title,
        style: style ??
            TextStyle(
              color: Theme.of(context).textTheme.subtitle2.color,
              fontWeight: FontWeight.w500,
            ),
        textAlign: textAlign,
      ),
    );
  }

  static h(int level, String title, {Padding padding, TextStyle style, TextAlign textAlign}) => Builder(
        builder: (context) {
          final theme = Theme.of(context).textTheme;
          TextStyle baseStyle;
          switch (level) {
            case 1:
              baseStyle = theme.headline1;
              break;
            case 2:
              baseStyle = theme.headline2;
              break;
            case 3:
              baseStyle = theme.headline3;
              break;
            case 4:
              baseStyle = theme.headline4;
              break;
            case 5:
              baseStyle = theme.headline5;
              break;
            default:
              baseStyle = theme.headline6;
          }
          return SectionTitle(
            title,
            padding: padding ?? EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
            style: style ??
                TextStyle(
                  color: baseStyle.color,
                  fontSize: baseStyle.fontSize,
                  fontWeight: FontWeight.w500,
                ),
            textAlign: textAlign ?? TextAlign.center,
          );
        },
      );
}
