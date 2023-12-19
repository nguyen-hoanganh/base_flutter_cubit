import 'dart:async';

import 'package:cbp_mobile_app_flutter/common/components/skeleton/shimmer_manager.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

part 'models/skeleton_configs.dart';

class Skeleton extends StatelessWidget {
  final SkeletonConfigs configs;

  const Skeleton({
    Key? key,
    required this.configs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SkeletonPrivate(configs: configs);
  }
}

class _SkeletonPrivate extends StatefulWidget {
  final SkeletonConfigs configs;

  _SkeletonPrivate({
    Key? key,
    required SkeletonConfigs configs,
  })  : configs = setDefaultValuesToConfigs(configs),
        super(key: key);

  static SkeletonConfigs setDefaultValuesToConfigs(
    SkeletonConfigs passedConfigs,
  ) {
    Color color;
    switch (passedConfigs.type$) {
      case SkeletonType.secondary:
        color = CommonColors.neutralColor5;
        break;
      default:
        color = CommonColors.neutralColor7;
        break;
    }

    return passedConfigs.copyWith(color: passedConfigs.color ?? color);
  }

  @override
  State<_SkeletonPrivate> createState() => _SkeletonPrivateState();
}

class _SkeletonPrivateState extends State<_SkeletonPrivate> {
  double _opacity = ShimmerManager.shared.currentOpacity;
  StreamSubscription<bool>? _streamSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = ShimmerManager.shared.isAnimationForward
            ? ShimmerManager.shared.minOpacity
            : ShimmerManager.shared.maxOpacity;
      });
    });

    _streamSubscription =
        ShimmerManager.shared.stream.listen((isAnimationForward) {
      setState(() {
        _opacity = isAnimationForward
            ? ShimmerManager.shared.minOpacity
            : ShimmerManager.shared.maxOpacity;
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(milliseconds: ShimmerManager.shared.duration),
      child: Container(
        width: widget.configs.width,
        height: widget.configs.height,
        decoration: BoxDecoration(
          color: widget.configs.color,
          borderRadius: widget.configs.borderRadius$,
        ),
      ),
    );
  }
}
