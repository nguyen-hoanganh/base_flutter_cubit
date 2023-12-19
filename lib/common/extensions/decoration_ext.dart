import 'package:flutter/material.dart';

extension BoxDecorationExt on BoxDecoration {
  BoxDecoration shadow() => copyWith(
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(1, 2),
          ),
        ],
      );
}
