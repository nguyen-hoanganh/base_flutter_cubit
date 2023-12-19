import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';

class LoadingManager {
  LoadingManager._internal();
  static LoadingManager? _instance;

  static LoadingManager get shared {
    _instance ??= LoadingManager._internal();

    return _instance!;
  }

  OverlaySupportEntry? _overlay;
  final List<dynamic> _stack = [];

  bool get isShowing => _overlay != null;

  void show({
    BuildContext? context,
    String? tag,
  }) {
    try {
      _stack.add(tag);

      _overlay ??= showOverlay(
        (_, __) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => {},
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Container(
                width: 86.s,
                height: 86.s,
                padding: EdgeInsets.all(24.s),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    4.s,
                  ),
                  color: CommonColors.neutralColor6.withOpacity(0.8),
                ),
                child: Loading(),
              ),
            ),
          ),
        ),
        context: context,
        duration: Duration.zero,
      );
    } catch (e) {
      _stack.remove(tag);
      _overlay = null;
    }
  }

  void hide({String? tag}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      _stack.remove(tag);

      if (_stack.isEmpty) {
        _overlay?.dismiss(animate: false);
        _overlay = null;
      }
    } catch (e) {
      _overlay = null;
    }
  }

  void clear() {
    _stack.clear();
    hide();
  }
}
