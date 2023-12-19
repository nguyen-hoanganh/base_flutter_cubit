import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
  bool get hasSafeAreaTop => viewPadding.top > 0;
  bool get hasSafeAreaBottom => viewPadding.bottom > 0;
}
