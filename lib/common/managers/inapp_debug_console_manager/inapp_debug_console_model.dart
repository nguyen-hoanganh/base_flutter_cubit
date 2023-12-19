import 'package:flutter/material.dart';

enum InAppDebugConsoleModelType {
  print,
  log,
  verbose,
  debug,
  info,
  warning,
  error,
}

class InAppDebugConsoleModel {
  final InAppDebugConsoleModelType type;
  final Color color;
  final dynamic message;
  final dynamic error;
  final dynamic stackTrace;

  InAppDebugConsoleModel({
    required this.type,
    required this.message,
    this.error,
    this.stackTrace,
  }) : color = _getColorByType(type);

  static Color _getColorByType(InAppDebugConsoleModelType type) {
    switch (type) {
      case InAppDebugConsoleModelType.print:
        return const Color(0xFF2c7dff);
      case InAppDebugConsoleModelType.log:
        return const Color(0xFFc58954);
      case InAppDebugConsoleModelType.verbose:
        return const Color(0xFF79b652);
      case InAppDebugConsoleModelType.debug:
        return const Color(0xFF37a2b3);
      case InAppDebugConsoleModelType.info:
        return const Color(0xFFb244d7);
      case InAppDebugConsoleModelType.warning:
        return const Color(0xFFc27a41);
      case InAppDebugConsoleModelType.error:
        return const Color(0xFFcf3c4e);
    }
  }

  InAppDebugConsoleModel._({
    required this.type,
    required this.color,
    required this.message,
    this.error,
    this.stackTrace,
  });

  InAppDebugConsoleModel copyWith({
    InAppDebugConsoleModelType? type,
    Color? color,
    dynamic message,
    dynamic error,
    dynamic stackTrace,
  }) {
    return InAppDebugConsoleModel._(
      type: type ?? this.type,
      color: color ?? this.color,
      message: message ?? this.message,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}
