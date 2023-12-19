import 'package:cbp_mobile_app_flutter/common/configs/config_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/inapp_debug_console_manager/in_app_debug_console_widget.dart';
import 'package:flutter/material.dart';

import 'package:overlay_support/overlay_support.dart';

class BubbleMenuManager {
  BubbleMenuManager._internal();
  static BubbleMenuManager? _instance;

  static BubbleMenuManager get shared {
    _instance ??= BubbleMenuManager._internal();

    return _instance!;
  }

  OverlaySupportEntry? _overlay;
  bool get isShowing => _overlay != null;

  void show(BuildContext? context) {
    if (!_canDebug) return;

    if (isShowing) hide();

    try {
      _overlay ??= showOverlay(
        (_, __) => const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BubbleMenuWidget(),
        ),
        context: context,
        duration: Duration.zero,
      );
    } catch (e) {
      _overlay = null;
    }
  }

  void hide() {
    try {
      _overlay?.dismiss(animate: false);
      _overlay = null;
    } catch (e) {
      _overlay = null;
    }
  }

  bool get _canDebug =>
      ConfigManager.getInstance().appFlavor == FlavorManager.dev;
}
