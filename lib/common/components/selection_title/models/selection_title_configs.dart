import 'package:flutter/material.dart';

class SelectionTitleConfigs {
  const SelectionTitleConfigs({
    this.showSuffix,
    this.suffix,
    this.title,
    this.isShowDivider,
  });

  final bool? showSuffix;
  final Widget? suffix;
  final String? title;
  final bool? isShowDivider;
  SelectionTitleConfigs copyWith({
    bool? showSuffix,
    Widget? suffix,
    String? title,
    bool? isShowDivider,
  }) {
    return SelectionTitleConfigs(
      showSuffix: showSuffix ?? this.showSuffix,
      suffix: suffix ?? this.suffix,
      title: title ?? this.title,
      isShowDivider: isShowDivider ?? this.isShowDivider,
    );
  }
}
