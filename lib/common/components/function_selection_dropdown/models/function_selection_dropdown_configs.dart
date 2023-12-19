part of '../function_selection_dropdown.dart';

class FunctionSelectionDropdownConfigs {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? title;
  final TextStyle? titleStyle;
  final Widget? customTitle;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool? hasBoxShadow;
  final bool? showPrefix;
  final bool? showSuffix;

  FunctionSelectionDropdownConfigs({
    this.prefixIcon,
    this.suffixIcon,
    this.title,
    this.titleStyle,
    this.customTitle,
    this.padding,
    this.onTap,
    this.hasBoxShadow,
    this.showPrefix,
    this.showSuffix,
  });

  FunctionSelectionDropdownConfigs copyWith(
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? title,
    TextStyle? titleStyle,
    Widget? customTitle,
    EdgeInsets? padding,
    Function()? onTap,
    bool? hasBoxShadow,
    bool? showPrefix,
    bool? showSuffix,
  ) =>
      FunctionSelectionDropdownConfigs(
        prefixIcon: prefixIcon ?? this.prefixIcon,
        suffixIcon: prefixIcon ?? this.suffixIcon,
        title: title ?? this.title,
        titleStyle: titleStyle ?? this.titleStyle,
        customTitle: customTitle ?? this.customTitle,
        padding: padding ?? this.padding,
        onTap: onTap ?? this.onTap,
        hasBoxShadow: hasBoxShadow ?? this.hasBoxShadow,
        showPrefix: showPrefix ?? this.showPrefix,
        showSuffix: showSuffix ?? this.showSuffix,
      );

  Widget get suffixIcon$ => suffixIcon ?? Assets.svgs.arrowRight.svg();

  EdgeInsets get padding$ => padding ?? EdgeInsets.all(12.s);

  TextStyle get titleStyle$ =>
      titleStyle ??
      CommonTextStyle.supportFontTitle4
          .copyWith(color: CommonColors.primaryColor1);

  bool get hasBoxShadow$ => hasBoxShadow ?? true;

  bool get showPrefix$ => showPrefix ?? true;

  bool get showSuffix$ => showSuffix ?? true;
}
