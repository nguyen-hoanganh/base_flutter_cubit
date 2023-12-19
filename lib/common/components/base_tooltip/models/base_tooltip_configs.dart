part of '../base_tooltip.dart';

enum BaseTooltipType {
  information,
  instruction,
  errorWarning,
  errorDanger,
}

enum BaseTooltipLayout { top, bottom }

class BaseTooltipConfigs {
  final BaseTooltipType? type;
  final BaseTooltipLayout? layout;
  final Widget? child;
  final Widget? content;
  final JustTheController? controller;
  final Duration? duration;

  BaseTooltipConfigs({
    this.type,
    this.layout,
    this.child,
    this.content,
    this.controller,
    this.duration,
  });

  BaseTooltipConfigs copyWith({
    BaseTooltipType? type,
    BaseTooltipLayout? layout,
    Widget? child,
    Widget? content,
    JustTheController? controller,
    Duration? duration,
  }) {
    return BaseTooltipConfigs(
      type: type ?? this.type,
      layout: layout ?? this.layout,
      child: child ?? this.child,
      content: content ?? this.content,
      controller: controller ?? this.controller,
      duration: duration ?? this.duration,
    );
  }

  BaseTooltipType get type$ => type ?? BaseTooltipType.information;
  BaseTooltipLayout get layout$ => layout ?? BaseTooltipLayout.bottom;
  Duration get duration$ => duration ?? const Duration(seconds: 0);

  Color get backgroundColor$ {
    switch (type$) {
      case BaseTooltipType.information:
        return CommonColors.primaryColor2;
      case BaseTooltipType.instruction:
        return CommonColors.secondaryColor4;
      case BaseTooltipType.errorWarning:
        return CommonColors.accentColor3;
      case BaseTooltipType.errorDanger:
        return CommonColors.accentColor2;
      default:
        return CommonColors.primaryColor2;
    }
  }
}
