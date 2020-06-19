import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

void _defaultSetState(void Function() fn) => fn();

String validateNonEmpty(String value) {
  if (value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

abstract class EventEditorState<T extends StatefulWidget> extends State<T> {
  Map<String, dynamic> event;

  Widget textField(
    String name, {
    String label,
    validator = validateNonEmpty,
    bool multiline = false,
  }) {
    return MapTextFormField(
      name,
      map: event,
      setState: setState,
      label: label,
      validator: validator,
      multiline: multiline,
    );
  }
}

/// A text field that edits an entry in a map
class MapTextFormField extends StatelessWidget {
  final String name;
  final Map<String, dynamic> map;
  final void Function(Function()) setState;
  final String label;
  final String Function(String) validator;
  final bool multiline;

  const MapTextFormField(
    this.name, {
    Key key,
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
