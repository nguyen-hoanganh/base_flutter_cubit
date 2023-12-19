part of '../button.dart';

enum ButtonType {
  primary,
  secondary,
}

enum ButtonState {
  default$,
  loading,
  error,
}

class ButtonConfigs {
  final ButtonType? type;
  final ButtonState? state;

  final double? width;
  final double? height;

  final String? content;
  final TextStyle? contentStyle;
  final Widget? customContentWidget;
  final Color? contentColor;

  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Border? border;
  final Gradient? gradient;

  final bool? disabled;
  final bool? isContentAllCaps;
  final bool? isContentUnderline;
  final TextOverflow? contentOverflow;
  final int? contentMaxLines;

  final Widget Function(ButtonConfigs currentConfig)? customLoadingWidget;

  final Function()? onTap;
  final Future Function()? onTapWithLoading;

  ButtonConfigs({
    this.type,
    this.state,
    this.width,
    this.height,
    this.content,
    this.contentStyle,
    this.customContentWidget,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.border,
    this.disabled,
    this.isContentAllCaps,
    this.isContentUnderline,
    this.contentOverflow,
    this.contentMaxLines,
    this.customLoadingWidget,
    this.onTap,
    this.onTapWithLoading,
    this.gradient,
    this.contentColor,
  });

  ButtonConfigs copyWith({
    ButtonType? type,
    ButtonState? state,
    double? width,
    double? height,
    String? content,
    TextStyle? contentStyle,
    Widget? customContentWidget,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    Border? border,
    bool? disabled,
    bool? isContentAllCaps,
    bool? isContentUnderline,
    TextOverflow? contentOverflow,
    int? contentMaxLines,
    Widget Function(ButtonConfigs currentConfig)? customLoadingWidget,
    Function()? onTap,
    Future Function()? onTapWithLoading,
    Gradient? gradient,
    Color? contentColor,
    EdgeInsetsGeometry? customLeadingPadding,
  }) {
    return ButtonConfigs(
      type: type ?? this.type,
      state: state ?? this.state,
      width: width ?? this.width,
      height: height ?? this.height,
      content: content ?? this.content,
      contentStyle: contentStyle ?? this.contentStyle,
      customContentWidget: customContentWidget ?? this.customContentWidget,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      disabled: disabled ?? this.disabled,
      isContentAllCaps: isContentAllCaps ?? this.isContentAllCaps,
      isContentUnderline: isContentUnderline ?? this.isContentUnderline,
      contentOverflow: contentOverflow ?? this.contentOverflow,
      contentMaxLines: contentMaxLines ?? this.contentMaxLines,
      customLoadingWidget: customLoadingWidget ?? this.customLoadingWidget,
      onTap: onTap ?? this.onTap,
      onTapWithLoading: onTapWithLoading ?? this.onTapWithLoading,
      gradient: gradient ?? this.gradient,
      contentColor: contentColor ?? this.contentColor,
    );
  }

  ButtonType get type$ => type ?? ButtonType.primary;
  ButtonState get state$ => state ?? ButtonState.default$;

  bool get disabled$ => disabled ?? false;
  bool get isContentAllCaps$ => isContentAllCaps ?? false;
  bool get isContentUnderline$ => isContentUnderline ?? false;
}
