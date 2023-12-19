import 'package:cbp_mobile_app_flutter/common/components/button/gesture_detector/gesture_detector_throttle/gesture_detector_throttle.dart';
import 'package:flutter/material.dart';

export '../models/gesture_detector_configs.dart';

class GestureDetectorOpacity extends StatefulWidget {
  final GestureDetectorConfigs configs;
  final double opacity;

  const GestureDetectorOpacity({
    super.key,
    required this.configs,
    this.opacity = 0.8,
  });

  @override
  State<GestureDetectorOpacity> createState() => _GestureDetectorOpacityState();
}

class _GestureDetectorOpacityState extends State<GestureDetectorOpacity> {
  bool _isTouched = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetectorThrottle(
      onTapWithoutThrottle: () async {
        setState(() {
          _isTouched = true;
        });
        await Future.delayed(const Duration(milliseconds: 100));
        if (mounted) {
          setState(() {
            _isTouched = false;
          });
        }
      },
      configs: widget.configs.copyWith(
        onTapDown: (details) {
          setState(() {
            _isTouched = true;
          });
          widget.configs.onTapDown?.call(details);
        },
        onTapUp: (details) {
          setState(() {
            _isTouched = false;
          });
          widget.configs.onTapUp?.call(details);
        },
        onTapCancel: () {
          setState(() {
            _isTouched = false;
          });
          widget.configs.onTapCancel?.call();
        },
        onLongPress: () {
          setState(() {
            _isTouched = true;
          });
          widget.configs.onLongPress?.call();
        },
        onLongPressStart: (detailts) {
          setState(() {
            _isTouched = true;
          });
          widget.configs.onLongPressStart?.call(detailts);
        },
        onLongPressEnd: (detailts) {
          setState(() {
            _isTouched = false;
          });
          widget.configs.onLongPressEnd?.call(detailts);
        },
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 100),
          opacity: _isTouched ? widget.opacity : 1,
          child: widget.configs.child,
        ),
      ),
    );
  }
}
