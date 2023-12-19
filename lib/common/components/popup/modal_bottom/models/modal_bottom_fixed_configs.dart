part of '../modal_bottom.dart';

enum ModalBottomFixedSize { s, m, l }

class ModalBottomFixedConfigs {
  final ModalBottomFixedSize? size;
  final bool? enableDrag;
  final Widget? body;

  const ModalBottomFixedConfigs({
    this.size,
    this.enableDrag,
    this.body,
  });

  ModalBottomFixedSize get size$ => size ?? ModalBottomFixedSize.s;
  bool get enableDrag$ => enableDrag ?? true;
  Widget get body$ => body ?? const SizedBox.shrink();
}
