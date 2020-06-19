import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

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
    return TextFormField(
      decoration: InputDecoration(labelText: label ?? capitalize(name)),
      initialValue: event[name] ?? '',
      onSaved: (value) {
        setState(() {
          event[name] = value;
        });
      },
      validator: validator,
      maxLines: multiline ? 5 : 1,
    );
  }
}
