// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cbp_mobile_app_flutter/common/components/navigation_bar/navigation_bar_top.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BaseScaffoldConfigs {
  // Custom props
  final PreferredSizeWidget? customNavigationTop;
  final NavigationBarTopConfigs? navigationBarTopConfigs;

  // Extends Scaffold props
  final AppBar? appBar;
  final GlobalKey<ScaffoldState>? key;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  BaseScaffoldConfigs({
    this.customNavigationTop,
    this.navigationBarTopConfigs,
    this.appBar,
    this.key,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.drawerScrimColor,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  });

  BaseScaffoldConfigs copyWith({
    PreferredSizeWidget? customNavigationTop,
    AppBar? appBar,
    GlobalKey<ScaffoldState>? key,
    bool? extendBody,
    bool? extendBodyBehindAppBar,
    Widget? body,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    FloatingActionButtonAnimator? floatingActionButtonAnimator,
    List<Widget>? persistentFooterButtons,
    AlignmentDirectional? persistentFooterAlignment,
    Widget? drawer,
    DrawerCallback? onDrawerChanged,
    Widget? endDrawer,
    DrawerCallback? onEndDrawerChanged,
    Color? drawerScrimColor,
    Color? backgroundColor,
    Widget? bottomNavigationBar,
    Widget? bottomSheet,
    bool? resizeToAvoidBottomInset,
    DragStartBehavior? drawerDragStartBehavior,
    double? drawerEdgeDragWidth,
    bool? drawerEnableOpenDragGesture,
    bool? endDrawerEnableOpenDragGesture,
    String? restorationId,
  }) {
    return BaseScaffoldConfigs(
      customNavigationTop: customNavigationTop ?? this.customNavigationTop,
      appBar: appBar ?? this.appBar,
      key: key ?? this.key,
      extendBody: extendBody ?? this.extendBody,
      extendBodyBehindAppBar:
          extendBodyBehindAppBar ?? this.extendBodyBehindAppBar,
      body: body ?? this.body,
      floatingActionButton: floatingActionButton ?? this.floatingActionButton,
      floatingActionButtonLocation:
          floatingActionButtonLocation ?? this.floatingActionButtonLocation,
      floatingActionButtonAnimator:
          floatingActionButtonAnimator ?? this.floatingActionButtonAnimator,
      persistentFooterButtons:
          persistentFooterButtons ?? this.persistentFooterButtons,
      persistentFooterAlignment:
          persistentFooterAlignment ?? this.persistentFooterAlignment,
      drawer: drawer ?? this.drawer,
      onDrawerChanged: onDrawerChanged ?? this.onDrawerChanged,
      endDrawer: endDrawer ?? this.endDrawer,
      onEndDrawerChanged: onEndDrawerChanged ?? this.onEndDrawerChanged,
      drawerScrimColor: drawerScrimColor ?? this.drawerScrimColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      bottomNavigationBar: bottomNavigationBar ?? this.bottomNavigationBar,
      bottomSheet: bottomSheet ?? this.bottomSheet,
      resizeToAvoidBottomInset:
          resizeToAvoidBottomInset ?? this.resizeToAvoidBottomInset,
      drawerDragStartBehavior:
          drawerDragStartBehavior ?? this.drawerDragStartBehavior,
      drawerEdgeDragWidth: drawerEdgeDragWidth ?? this.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture:
          drawerEnableOpenDragGesture ?? this.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture:
          endDrawerEnableOpenDragGesture ?? this.endDrawerEnableOpenDragGesture,
      restorationId: restorationId ?? this.restorationId,
    );
  }

  Color get backgroundColor$ => backgroundColor ?? Colors.transparent;
}
