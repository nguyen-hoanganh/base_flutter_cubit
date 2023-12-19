import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

enum LoadingType {
  gettingList,
  start,
}

class Loading extends StatelessWidget {
  final double? _width;
  final double? _height;

  final Color _color;
  final LoadingType? loadingType;

  Loading({
    Key? key,
    double? width,
    double? height,
    Color? color,
    this.loadingType = LoadingType.start,
  })  : _width = width ?? 40.s,
        _height = height ?? 40.s,
        _color = color ?? Colors.transparent,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildLottieWidget(
      name: 'assets/lottie/loading.json',
      scale: 2,
    );
  }

  Widget _buildLottieWidget({
    required String name,
    double? scale,
  }) {
    return SizedBox(
      width: _width,
      height: _height,
      child: Transform.scale(
        scale: scale ?? 1,
        child: Lottie.asset(
          name,
          delegates: LottieDelegates(
            values: [
              ValueDelegate.color(
                const ['**'],
                value: _color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
