import 'dart:math';

import 'package:cbp_mobile_app_flutter/common/extensions/object_ext.dart';
import 'package:flutter/material.dart';

class ContainerLinearGradientScale extends StatefulWidget {
  final LinearGradient? gradient;
  final BoxDecoration decoration;
  final Widget? child;

  const ContainerLinearGradientScale({
    super.key,
    this.gradient,
    this.decoration = const BoxDecoration(),
    this.child,
  });

  @override
  State<ContainerLinearGradientScale> createState() =>
      _ContainerLinearGradientScaleState();
}

class _ContainerLinearGradientScaleState
    extends State<ContainerLinearGradientScale> {
  final _containerKey = GlobalKey();
  Size? _containerSize;
  // Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getContainerSize();
      // _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      //   _getContainerSize();
      // });
    });
  }

  @override
  void dispose() {
    // _timer?.cancel();
    // _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      key: _containerKey,
      decoration: widget.decoration.copyWith(
        gradient: _scaleGradient(),
      ),
      child: widget.child,
    );
  }

  LinearGradient _scaleGradient() {
    final gradient = widget.gradient ?? const LinearGradient(colors: []);

    final begin = safeCast<Alignment>(gradient.begin);
    final end = safeCast<Alignment>(gradient.end);

    if (_containerSize != null && begin != null && end != null) {
      final size = _containerSize!;

      final width = size.width;
      final height = size.height;

      final newBeginX = begin.x / pow(width / height, 2);
      final newEndX = end.x / pow(width / height, 2);

      return LinearGradient(
        colors: gradient.colors,
        begin: Alignment(newBeginX, begin.y),
        end: Alignment(newEndX, end.y),
        stops: gradient.stops,
        tileMode: gradient.tileMode,
        transform: gradient.transform,
      );
    }

    return gradient;
  }

  void _getContainerSize() {
    Size? size;
    try {
      size = _containerKey.currentContext?.size;
    } catch (_) {
      size = _containerSize;
    }
    if (size == null) return;

    if (_containerSize == null) {
      setState(() {
        _containerSize = size;
      });
    } else {
      if (_containerSize!.width != size.width ||
          _containerSize!.height != size.height) {
        setState(() {
          _containerSize = size;
        });
      }
    }
  }
}
