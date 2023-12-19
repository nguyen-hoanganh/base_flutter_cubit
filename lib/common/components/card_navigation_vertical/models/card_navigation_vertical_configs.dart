part of '../card_navigation_vertical.dart';

enum CardNavigationVerticalColorType {
  primary,
  accent,
}

class CardNavigationVerticalConfigs {
  final CardNavigationVerticalColorType? color;
  final String? title;
  final String? subTitle;
  final Widget? prefixIcon;
  final bool? showPrefix;
  final bool? showSubtitle;
  final bool? hasBoxShadow;
  final EdgeInsets? padding;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final Color? backgroundHeader;
  final Widget? customSub;
  final Function()? onTap;

  CardNavigationVerticalConfigs({
    this.color,
    this.title,
    this.subTitle,
    this.prefixIcon,
    this.showPrefix,
    this.showSubtitle,
    this.hasBoxShadow,
    this.padding,
    this.titleStyle,
    this.subTitleStyle,
    this.backgroundHeader,
    this.customSub,
    this.onTap,
  });

  CardNavigationVerticalConfigs copyWith({
    CardNavigationVerticalColorType? color,
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
    Widget? customSub,
    Function()? onTap,
  }) {
    return CardNavigationVerticalConfigs(
      color: color ?? this.color,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      showPrefix: showPrefix ?? this.showPrefix,
      showSubtitle: showSubtitle ?? this.showSubtitle,
      hasBoxShadow: hasBoxShadow ?? this.hasBoxShadow,
      padding: padding ?? this.padding,
      titleStyle: titleStyle ?? this.titleStyle,
      subTitleStyle: subTitleStyle ?? this.subTitleStyle,
      backgroundHeader: backgroundHeader ?? backgroundHeader,
      onTap: onTap ?? this.onTap,
      customSub: customSub ?? this.customSub,
    );
  }

  CardNavigationVerticalColorType get color$ =>
      color ?? CardNavigationVerticalColorType.primary;

  EdgeInsets get padding$ => padding ?? EdgeInsets.all(12.s);

  TextStyle get titleStyle$ =>
      titleStyle ??
      CommonTextStyle.supportFontTitle4.copyWith(
        color: color$ == CardNavigationVerticalColorType.primary
            ? CommonColors.primaryColor1
            : CommonColors.neutralColor7,
      );

  TextStyle get subTitleStyle$ =>
      subTitleStyle ??
      CommonTextStyle.scriptSubtitle1.copyWith(
        color: color$ == CardNavigationVerticalColorType.primary
            ? CommonColors.neutralColor3
            : CommonColors.neutralColor7,
      );

  bool get hasBoxShadow$ => hasBoxShadow ?? true;

  bool get showPrefix$ => showPrefix ?? true;

  bool get showSubtitle$ => showSubtitle ?? true;

  Color get backgroundHeader$ =>
      backgroundHeader ??
      (color$ == CardNavigationVerticalColorType.primary
          ? CommonColors.neutralColor7
          : CommonColors.accentColor1);
}
