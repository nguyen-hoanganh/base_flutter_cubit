part of '../navigation_bar_top.dart';

class NavigationBarTopConfigs {
  final double? height;

  final String? pageTitle;
  final Widget? customTitle;
  final double? titleLeadingSpacing;

  final bool? hasBackIcon;
  final Widget? customBackIcon;
  final Function()? onBackPress;

  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final BoxDecoration? backgroundDecoration;

  final List<BoxShadow>? boxShadow;

  final List<Widget>? customActions;
  final bool? hasRightActions;

  NavigationBarTopConfigs({
    this.height,
    this.pageTitle,
    this.customTitle,
    this.titleLeadingSpacing,
    this.hasBackIcon,
    this.customBackIcon,
    this.onBackPress,
    this.backgroundColor,
    this.borderRadius,
    this.backgroundDecoration,
    this.boxShadow,
    this.customActions,
    this.hasRightActions,
  });

  NavigationBarTopConfigs copyWith({
    double? height,
    String? pageTitle,
    Widget? customTitle,
    double? titleLeadingSpacing,
    bool? hasBackIcon,
    Widget? customBackIcon,
    Function()? onBackPress,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    BoxDecoration? backgroundDecoration,
    bool? isScrolling,
    bool? isBackgroundBlur,
    List<BoxShadow>? boxShadow,
    GlobalKey<ScaffoldState>? drawerGlobalKey,
    List<Widget>? customActions,
    bool? hasRightActions,
  }) {
    return NavigationBarTopConfigs(
      height: height ?? this.height,
      pageTitle: pageTitle ?? this.pageTitle,
      customTitle: customTitle ?? this.customTitle,
      titleLeadingSpacing: titleLeadingSpacing ?? this.titleLeadingSpacing,
      hasBackIcon: hasBackIcon ?? this.hasBackIcon,
      customBackIcon: customBackIcon ?? this.customBackIcon,
      onBackPress: onBackPress ?? this.onBackPress,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
      boxShadow: boxShadow ?? this.boxShadow,
      customActions: customActions ?? this.customActions,
      hasRightActions: hasRightActions ?? this.hasRightActions,
    );
  }
}
