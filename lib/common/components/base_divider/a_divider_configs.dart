import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

enum ADividerType { spacing, line, dash, information }

class ADividerConfigs {
  final ADividerType? type;
  final double? width;
  final double? strokeWidth;
  final Color? color;

  final double? spacingTop;
  final bool? isShowSpacingTop;

  final double? spacingBottom;
  final bool? isShowSpacingBottom;

  const ADividerConfigs({
    this.type,
    this.width,
    this.strokeWidth,
    this.color,
    this.spacingTop,
    this.isShowSpacingTop,
    this.spacingBottom,
    this.isShowSpacingBottom,
  });

  ADividerConfigs copyWith({
    ADividerType? type,
    double? width,
    double? strokeWidth,
    Color? color,
    double? spacingTop,
    bool? isShowSpacingTop,
    double? spacingBottom,
    bool? isShowSpacingBottom,
  }) {
    return ADividerConfigs(
      type: type ?? this.type,
      width: width ?? this.width,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      color: color ?? this.color,
      spacingTop: spacingTop ?? this.spacingTop,
      isShowSpacingTop: isShowSpacingTop ?? this.isShowSpacingTop,
      spacingBottom: spacingBottom ?? this.spacingBottom,
      isShowSpacingBottom: isShowSpacingBottom ?? this.isShowSpacingBottom,
    );
  }

  ADividerType get type$ => type ?? ADividerType.spacing;

  double get spacingTop$ => spacingTop ?? 10.s;

  bool get isShowSpacingTop$ => isShowSpacingTop ?? true;

  double get spacingBottom$ => spacingBottom ?? 10.s;

  bool get isShowSpacingBottom$ => isShowSpacingBottom ?? true;

  Color get color$ => color ?? CommonColors.secondaryColor5;
}
