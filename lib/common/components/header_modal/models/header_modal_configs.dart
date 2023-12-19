// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../header_modal.dart';

class HeaderModalConfigs {
  final String title;
  final bool isBackground;
  final bool isShowTitle;
  final Color? colorShape;
  final Widget? rightWidget;

  HeaderModalConfigs({
    this.title = "",
    this.isBackground = true,
    this.isShowTitle = true,
    this.colorShape,
    this.rightWidget,
  });

  HeaderModalConfigs copyWith({
    String? title,
    bool? isBackground,
    bool? isShowTitle,
    Color? colorShape,
    Widget? rightWidget,
  }) {
    return HeaderModalConfigs(
      title: title ?? this.title,
      isBackground: isBackground ?? this.isBackground,
      isShowTitle: isShowTitle ?? this.isShowTitle,
      colorShape: colorShape ?? this.colorShape,
      rightWidget: rightWidget ?? this.rightWidget,
    );
  }
}
