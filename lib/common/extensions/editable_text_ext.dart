import 'package:flutter/material.dart';

extension TextEditingControllerExt on TextEditingController {
  int get length => text.length;

  void setText(String pin) {
    text = pin;
    moveCursorToEnd();
  }

  void delete() {
    if (text.isEmpty) return;
    final pin = text.substring(0, length - 1);
    text = pin;
    moveCursorToEnd();
  }

  void append(String s, int maxLength) {
    if (length == maxLength) return;
    text = '$text$s';
    moveCursorToEnd();
  }

  /// Moves cursor at the end
  void moveCursorToEnd() {
    selection = TextSelection.collapsed(offset: length);
  }
}
