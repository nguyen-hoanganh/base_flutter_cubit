import 'package:flutter/material.dart';

class SizedBoxSafeArea extends StatelessWidget {
  final double? width;
  final double? height;
  final bool isIncludeTopSafeArea;
  final bool isIncludeBottomSafeArea;

  const SizedBoxSafeArea({
    super.key,
    this.width,
    this.height,
    this.isIncludeTopSafeArea = false,
    this.isIncludeBottomSafeArea = false,
  });

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    double? heightValue = height;
    if (heightValue != null) {
      if (isIncludeTopSafeArea) {
        heightValue - padding.top;
      }
      if (isIncludeBottomSafeArea) {
        heightValue - padding.bottom;
      }
    }

    return SizedBox(
      width: width,
      height: heightValue,
    );
  }
}
