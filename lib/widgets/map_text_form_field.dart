
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

void _defaultSetState(void Function() fn) => fn();

String validateNonEmpty(String value) {
  if (value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

/// A text field that edits an entry in a map
class MapTextFormField extends StatelessWidget {
  final String name;
  final Map<String, dynamic> map;
  final void Function(Function()) setState;
  final String label;
  final String Function(String) validator;
  final bool multiline;

  const MapTextFormField({
    Key key,
    @required this.name,
    @required this.map,
    this.setState = _defaultSetState,
    String this.label,
    this.validator = validateNonEmpty,
    bool this.multiline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: label ?? capitalize(name)),
      initialValue: map[name] ?? '',
      onSaved: (value) {
        setState(() {
          map[name] = value;
        });
      },
      validator: validator,
      maxLines: multiline ? 5 : 1,
    );
  }
}
