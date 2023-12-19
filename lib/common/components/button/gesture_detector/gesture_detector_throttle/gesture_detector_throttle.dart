import 'dart:async';

import 'package:cbp_mobile_app_flutter/common/components/button/gesture_detector/models/gesture_detector_configs.dart';
import 'package:flutter/material.dart';

export '../models/gesture_detector_configs.dart';

class GestureDetectorThrottle extends StatefulWidget {
  final GestureDetectorConfigs configs;
  final GestureTapCallback? onTapWithoutThrottle;

  const GestureDetectorThrottle({
    super.key,
    required this.configs,
    this.onTapWithoutThrottle,
  });

  @override
  State<GestureDetectorThrottle> createState() =>
      _GestureDetectorThrottleState();
}

class _GestureDetectorThrottleState extends State<GestureDetectorThrottle> {
  Timer? _throttle;
  bool _canTap = true;

  @override
  void dispose() {
    _throttle?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.configs.isOpacityWhenDisabled
        ? Opacity(
            opacity:
                widget.configs.disabled ? widget.configs.opacityDisable : 1,
            child: widget.configs.child,
          )
        : widget.configs.child;

    if (widget.configs.disabled) return child;

    return GestureDetector(
      onTap: () {
        try {
          FocusScope.of(context).unfocus();

          widget.onTapWithoutThrottle?.call();
        } catch (_) {}

        if (widget.configs.onTap == null) return;
        if (!_canTap) return;

        _canTap = false;
        try {
          widget.configs.onTap?.call();
        } catch (_) {}

        _throttle?.cancel();

        _throttle = Timer(
          const Duration(milliseconds: 300),
          () => _canTap = true,
        );
      },
      onTapDown: widget.configs.onTapDown,
      onTapUp: widget.configs.onTapUp,
      onTapCancel: widget.configs.onTapCancel,
      onDoubleTap: widget.configs.onDoubleTap,
      onLongPress: widget.configs.onLongPress,
      onLongPressDown: widget.configs.onLongPressDown,
      onLongPressStart: widget.configs.onLongPressStart,
      onLongPressMoveUpdate: widget.configs.onLongPressMoveUpdate,
      onLongPressUp: widget.configs.onLongPressUp,
      onLongPressEnd: widget.configs.onLongPressEnd,
      onVerticalDragDown: widget.configs.onVerticalDragDown,
      onVerticalDragStart: widget.configs.onVerticalDragStart,
      onVerticalDragUpdate: widget.configs.onVerticalDragUpdate,
      onVerticalDragEnd: widget.configs.onVerticalDragEnd,
      onVerticalDragCancel: widget.configs.onVerticalDragCancel,
      onHorizontalDragDown: widget.configs.onHorizontalDragDown,
      onHorizontalDragStart: widget.configs.onHorizontalDragStart,
      onHorizontalDragUpdate: widget.configs.onHorizontalDragUpdate,
      onHorizontalDragEnd: widget.configs.onHorizontalDragEnd,
      onHorizontalDragCancel: widget.configs.onHorizontalDragCancel,
      onForcePressStart: widget.configs.onForcePressStart,
      onForcePressPeak: widget.configs.onForcePressPeak,
      onForcePressUpdate: widget.configs.onForcePressUpdate,
      onForcePressEnd: widget.configs.onForcePressEnd,
      onPanDown: widget.configs.onPanDown,
      onPanStart: widget.configs.onPanStart,
      onPanUpdate: widget.configs.onPanUpdate,
      onPanEnd: widget.configs.onPanEnd,
      onPanCancel: widget.configs.onPanCancel,
      onScaleStart: widget.configs.onScaleStart,
      onScaleUpdate: widget.configs.onScaleUpdate,
      onScaleEnd: widget.configs.onScaleEnd,
      behavior: widget.configs.behavior,
      excludeFromSemantics: widget.configs.excludeFromSemantics,
      dragStartBehavior: widget.configs.dragStartBehavior,
      child: child,
    );
  }
}
