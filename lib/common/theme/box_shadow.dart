import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonBoxShadow {
  CommonBoxShadow._();
  static BoxShadow shadowLight1 = BoxShadow(
    color: const Color.fromRGBO(136, 165, 219, 0.3),
    blurRadius: 4.s,
    offset: Offset(0, 4.s),
  );

  static BoxShadow shadowLight2 = BoxShadow(
    color: const Color.fromRGBO(136, 165, 219, 0.2),
    blurRadius: 4.s,
    offset: Offset(0, 4.s),
  );
}
