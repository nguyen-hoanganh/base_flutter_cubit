import 'package:cbp_mobile_app_flutter/common/components/button/gesture_detector/gesture_detector_throttle/gesture_detector_throttle.dart';
import 'package:flutter/material.dart';

export '../models/gesture_detector_configs.dart';

class GestureDetectorSwitcher extends StatefulWidget {
  final GestureDetectorConfigs configs;

  const GestureDetectorSwitcher({
    super.key,
    required this.configs,
  });

  @override
  State<GestureDetectorSwitcher> createState() =>
      _GestureDetectorSwitcherState();
}

class _GestureDetectorSwitcherState extends State<GestureDetectorSwitcher> {
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
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          // transitionBuilder: (Widget child, Animation<double> animation) {
          //   return FadeTransition(opacity: animation, child: child);
          // },
          child: !_isTouched
              ? widget.configs.child
              : Container(
                  child: widget.configs.secondaryChild,
                ),
        ),
      ),
    );
  }
}
