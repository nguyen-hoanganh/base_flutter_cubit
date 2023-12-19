// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../information.dart';

enum InformationLayout {
  titleBigger,
  titleSmaller,
  titleEqual,
}

/// (title < sub => 14, 16, 18) (title >= sub => 12, 14, 16)
enum InformationTextSize {
  s,
  m,
  l,
}

/// (title <= sub => 12, 14, 16) (title > sub => 14, 16, 18)
enum MContentHorizontalTextSize {
  s,
  m,
  l,
}

class InformationConfigs {
  const InformationConfigs({
    this.leadingText,
    this.leadingTextStyle,
    this.leadingFlex = 1,
    this.trailingText,
    this.trailingTextStyle,
    this.customTrailing,
    this.trailingFlex = 1,
    this.size,
    this.contentTextSize,
    this.mContentHorizontalTextSize,
    this.layout,
    this.isShowDivider,
    this.aDividerConfigs,
  });

  final String? leadingText;
  final TextStyle? leadingTextStyle;
  final int leadingFlex;
  final String? trailingText;
  final TextStyle? trailingTextStyle;
  final Widget? customTrailing;
  final int trailingFlex;
  final InformationTextSize? size;
  final InformationTextSize? contentTextSize;

  final MContentHorizontalTextSize? mContentHorizontalTextSize;
  final InformationLayout? layout;
  final bool? isShowDivider;
  final ADividerConfigs? aDividerConfigs;

  InformationConfigs copyWith({
    String? leadingText,
    TextStyle? leadingTextStyle,
    int? leadingFlex,
    String? trailingText,
    TextStyle? trailingTextStyle,
    Widget? customTrailing,
    int? trailingFlex,
    InformationTextSize? size,
    InformationTextSize? contentTextSize,
    MContentHorizontalTextSize? mContentHorizontalTextSize,
    InformationLayout? layout,
    bool? isShowDivider,
    ADividerConfigs? aDividerConfigs,
  }) {
    return InformationConfigs(
      leadingText: leadingText ?? this.leadingText,
      leadingTextStyle: leadingTextStyle ?? this.leadingTextStyle,
      leadingFlex: leadingFlex ?? this.leadingFlex,
      trailingText: trailingText ?? this.trailingText,
      trailingTextStyle: trailingTextStyle ?? this.trailingTextStyle,
      customTrailing: customTrailing ?? this.customTrailing,
      trailingFlex: trailingFlex ?? this.trailingFlex,
      size: size ?? this.size,
      contentTextSize: contentTextSize ?? this.contentTextSize,
      mContentHorizontalTextSize:
          mContentHorizontalTextSize ?? this.mContentHorizontalTextSize,
      layout: layout ?? this.layout,
      isShowDivider: isShowDivider ?? this.isShowDivider,
      aDividerConfigs: aDividerConfigs ?? this.aDividerConfigs,
    );
  }

  TextStyle get leadingStyle$ =>
      leadingTextStyle ??
      CommonTextStyle.bodyB4.copyWith(color: CommonColors.secondaryColor1);

  TextStyle get trailingStyle$ =>
      trailingTextStyle ??
      CommonTextStyle.bodyB4.copyWith(color: CommonColors.neutralColor1);
}
