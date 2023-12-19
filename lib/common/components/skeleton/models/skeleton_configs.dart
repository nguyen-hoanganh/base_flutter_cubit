part of '../skeleton.dart';

enum SkeletonType {
  primary,
  secondary,
}

class SkeletonConfigs {
  final SkeletonType? type;
  final double? width;
  final double? height;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;

  SkeletonConfigs({
    this.type,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
  });

  SkeletonConfigs copyWith({
    SkeletonType? type,
    double? width,
    double? height,
    Color? color,
    BorderRadiusGeometry? borderRadius,
  }) {
    return SkeletonConfigs(
      type: type ?? this.type,
      width: width ?? this.width,
      height: height ?? this.height,
      color: color ?? this.color,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  SkeletonType get type$ => type ?? SkeletonType.primary;

  BorderRadiusGeometry get borderRadius$ =>
      borderRadius ?? BorderRadius.all(Radius.circular(4.s));
}
