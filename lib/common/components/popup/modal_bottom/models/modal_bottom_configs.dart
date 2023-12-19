part of '../modal_bottom.dart';

enum ModalBottomSize {
  flexible,
  fixed,
  dragable,
}

enum ModalBottomFooter {
  noButton,
  singleButton,
  twoButton,
  custom,
}

class ModalBottomConfigs {
  final ModalBottomSize? size;
  final ModalBottomFooter? footer;
  final bool? isShowOverlayBackground;

  final ModalBottomFlexibleConfigs? flexibleConfigs;
  final ModalBottomFixedConfigs? fixedConfigs;
  final ModalBottomDragableConfigs? dragableConfigs;

  final String? title;
  final HeaderModalConfigs? mHeaderModalConfigs;

  final Widget? customFooter;

  final bool? isDismissible;
  final bool? hasSafeAreaTop;
  final bool? resizeToAvoidBottomInset;

  final Function()? onShow;
  final Function()? onDismiss;

  ModalBottomConfigs({
    this.size,
    this.footer,
    this.isShowOverlayBackground,
    this.flexibleConfigs,
    this.fixedConfigs,
    this.dragableConfigs,
    this.title,
    this.mHeaderModalConfigs,
    this.customFooter,
    this.isDismissible,
    this.hasSafeAreaTop,
    this.resizeToAvoidBottomInset,
    this.onShow,
    this.onDismiss,
  });

  ModalBottomConfigs copyWith({
    ModalBottomSize? size,
    ModalBottomFooter? footer,
    bool? isShowOverlayBackground,
    ModalBottomFlexibleConfigs? flexibleConfigs,
    ModalBottomFixedConfigs? fixedConfigs,
    ModalBottomDragableConfigs? dragableConfigs,
    String? title,
    HeaderModalConfigs? mHeaderModalConfigs,
    Widget? customFooter,
    bool? isDismissible,
    bool? hasSafeAreaTop,
    bool? resizeToAvoidBottomInset,
    Function()? onShow,
    Function()? onDismiss,
  }) {
    return ModalBottomConfigs(
      size: size ?? this.size,
      footer: footer ?? this.footer,
      isShowOverlayBackground:
          isShowOverlayBackground ?? this.isShowOverlayBackground,
      flexibleConfigs: flexibleConfigs ?? this.flexibleConfigs,
      fixedConfigs: fixedConfigs ?? this.fixedConfigs,
      dragableConfigs: dragableConfigs ?? this.dragableConfigs,
      title: title ?? this.title,
      mHeaderModalConfigs: mHeaderModalConfigs ?? this.mHeaderModalConfigs,
      customFooter: customFooter ?? this.customFooter,
      isDismissible: isDismissible ?? this.isDismissible,
      hasSafeAreaTop: hasSafeAreaTop ?? this.hasSafeAreaTop,
      resizeToAvoidBottomInset:
          resizeToAvoidBottomInset ?? this.resizeToAvoidBottomInset,
      onShow: onShow ?? this.onShow,
      onDismiss: onDismiss ?? this.onDismiss,
    );
  }

  ModalBottomSize get size$ => size ?? ModalBottomSize.flexible;
  ModalBottomFooter get footer$ => footer ?? ModalBottomFooter.singleButton;
  bool get isShowOverlayBackground$ => isShowOverlayBackground ?? true;
  bool get isDismissible$ => isDismissible ?? true;
  bool get hasSafeAreaTop$ => hasSafeAreaTop ?? true;
  bool get resizeToAvoidBottomInset$ => resizeToAvoidBottomInset ?? true;
}
