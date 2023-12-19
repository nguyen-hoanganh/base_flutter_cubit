part of '../modal_bottom.dart';

class ModalBottomFlexibleConfigs {
  final bool? enableDrag;
  final Widget? body;

  const ModalBottomFlexibleConfigs({
    this.enableDrag,
    this.body,
  });

  bool get enableDrag$ => enableDrag ?? true;
}
