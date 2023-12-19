part of '../expandable_widget.dart';

enum ExpandableWidgetColorType {
  primary,
  accent,
}

class ExpandableWidgetConfigs {
  final ExpandableWidgetColorType? color;
  final ExpandableController? controller;
  final String? title;
  final String? subTitle;
  final Widget? prefixIcon;
  final bool? showPrefix;
  final bool? showSubtitle;
  final bool? hasBoxShadow;
  final EdgeInsets? padding;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final bool? showClose;
  final Widget? child;
  final Color? backgroundHeader;
  final bool? initialValue;
  final Function()? onTapTitle;

  ExpandableWidgetConfigs({
    this.color,
    this.controller,
    this.title,
    this.subTitle,
    this.prefixIcon,
    this.showPrefix,
    this.showSubtitle,
    this.hasBoxShadow,
    this.padding,
    this.titleStyle,
    this.subTitleStyle,
    this.showClose,
    this.child,
    this.backgroundHeader,
    this.initialValue,
    this.onTapTitle,
  });

  ExpandableWidgetConfigs copyWith({
    ExpandableWidgetColorType? color,
    ExpandableController? controller,
    String? title,
    String? subTitle,
    Widget? prefixIcon,
    bool? showPrefix,
    bool? showSubtitle,
    bool? hasBoxShadow,
    EdgeInsets? padding,
    TextStyle? titleStyle,
    TextStyle? subTitleStyle,
    bool? showClose,
    Widget? child,
    Color? backgroundHeader,
    bool? initialValue,
    Function()? onTapTitle,
  }) {
    return ExpandableWidgetConfigs(
      color: color ?? this.color,
      controller: controller ?? this.controller,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      showPrefix: showPrefix ?? this.showPrefix,
      showSubtitle: showSubtitle ?? this.showSubtitle,
      hasBoxShadow: hasBoxShadow ?? this.hasBoxShadow,
      padding: padding ?? this.padding,
      titleStyle: titleStyle ?? this.titleStyle,
      subTitleStyle: subTitleStyle ?? this.subTitleStyle,
      showClose: showClose ?? this.showClose,
      child: child ?? this.child,
      backgroundHeader: backgroundHeader ?? this.backgroundHeader,
      initialValue: initialValue ?? this.initialValue,
      onTapTitle: onTapTitle ?? this.onTapTitle,
    );
  }

  ExpandableWidgetColorType get color$ =>
      color ?? ExpandableWidgetColorType.primary;

  EdgeInsets get padding$ => padding ?? EdgeInsets.all(12.s);

  TextStyle get titleStyle$ =>
      titleStyle ??
      CommonTextStyle.supportFontTitle4.copyWith(
        color: color$ == ExpandableWidgetColorType.primary
            ? CommonColors.primaryColor1
            : CommonColors.neutralColor7,
      );

  TextStyle get subTitleStyle$ =>
      subTitleStyle ??
      CommonTextStyle.scriptSubtitle1.copyWith(
        color: color$ == ExpandableWidgetColorType.primary
            ? CommonColors.neutralColor3
            : CommonColors.neutralColor7,
      );

  bool get hasBoxShadow$ => hasBoxShadow ?? true;

  bool get showPrefix$ => showPrefix ?? true;

  bool get showClose$ => showClose ?? true;

  bool get showSubtitle$ => showSubtitle ?? true;

  bool get initialValue$ => initialValue ?? false;

  Color get backgroundHeader$ =>
      backgroundHeader ??
      (color$ == ExpandableWidgetColorType.primary
          ? CommonColors.neutralColor7
          : CommonColors.accentColor1);

  ExpandableController get controller$ => controller ?? ExpandableController();
}
