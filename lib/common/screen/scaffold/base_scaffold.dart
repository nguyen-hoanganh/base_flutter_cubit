// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cbp_mobile_app_flutter/common/components/navigation_bar/navigation_bar_top.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:flutter/material.dart';

import 'package:cbp_mobile_app_flutter/common/screen/scaffold/base_scaffold_configs.dart';

class BaseScaffold extends StatelessWidget {
  final BaseScaffoldConfigs configs;
  const BaseScaffold({
    Key? key,
    required this.configs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = Scaffold(
      key: configs.key,
      appBar: _getAppBar(),
      extendBody: configs.extendBody,
      extendBodyBehindAppBar: configs.extendBodyBehindAppBar,
      floatingActionButton: configs.floatingActionButton,
      floatingActionButtonLocation: configs.floatingActionButtonLocation,
      floatingActionButtonAnimator: configs.floatingActionButtonAnimator,
      persistentFooterButtons: configs.persistentFooterButtons,
      persistentFooterAlignment: configs.persistentFooterAlignment,
      drawer: configs.drawer,
      onDrawerChanged: configs.onDrawerChanged,
      endDrawer: configs.endDrawer,
      onEndDrawerChanged: configs.onEndDrawerChanged,
      drawerScrimColor: configs.drawerScrimColor,
      backgroundColor: configs.backgroundColor$,
      bottomNavigationBar: configs.bottomNavigationBar,
      bottomSheet: configs.bottomSheet,
      resizeToAvoidBottomInset: configs.resizeToAvoidBottomInset,
      drawerDragStartBehavior: configs.drawerDragStartBehavior,
      drawerEdgeDragWidth: configs.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: configs.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: configs.endDrawerEnableOpenDragGesture,
      restorationId: configs.restorationId,
      body: configs.body,
    );

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          ///Fill background color
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: CommonColors.gradient3,
            ),
          ),
          child,
        ],
      ),
    );
  }

  PreferredSizeWidget? _getAppBar() {
    if (configs.customNavigationTop != null) {
      return configs.customNavigationTop;
    }

    if (configs.navigationBarTopConfigs != null) {
      return NavigationBarTop(
        configs: configs.navigationBarTopConfigs!.copyWith(
          drawerGlobalKey: configs.key,
        ),
      );
    }

    return null;
  }
}
