import 'package:flutter/material.dart';
import 'package:strings/strings.dart';
import 'package:yaml/yaml.dart';
import 'package:yamlicious/yamlicious.dart';

String validateNonEmpty(String value) {
  if (value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

String validateYaml(String value) {
  if (value.isEmpty) return null;
  try {
    var v = loadYaml(value);
    if (v is Map)
      return null;
    else
      return 'If additional data is provided, it must be a mapping';
  } catch (e) {
    return 'Invalid YAML';
  }
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

  Widget yamlField(
    String name, {
    String label,
    validator = validateYaml,
    bool multiline = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: label ?? capitalize(name)),
      initialValue: event[name] ?? '',
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          value = toYamlString(loadYaml(value));
        }
        setState(() {
          event[name] = value;
        });
      },
      validator: validator,
      maxLines: multiline ? 5 : 1,
    );
  }
}
