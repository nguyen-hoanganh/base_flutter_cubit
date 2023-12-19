part of '../modal_confirmation_dialog.dart';

class ModalConfirmationDialogConfigs {
  final String? title;
  final Widget? customTitleWidget;

  final String? message;
  final Widget? customMessageWidget;

  final bool? isVisibleIcon;
  final Widget? customIconWidget;
  final double? iconSize;

  final bool? isShowTitle;
  final bool? isVisibleCloseButton;
  final bool? barrierDismissible;

  final ButtonConfigs? buttonPrimaryConfig;
  final ButtonConfigs? buttonSecondaryConfig;

  final Function()? onClose;
  final Function()? onShow;
  final Function()? onDismiss;

  ModalConfirmationDialogConfigs({
    this.title,
    this.customTitleWidget,
    this.message,
    this.customMessageWidget,
    this.isVisibleIcon,
    this.customIconWidget,
    this.iconSize,
    this.isShowTitle,
    this.isVisibleCloseButton,
    this.barrierDismissible,
    this.buttonPrimaryConfig,
    this.buttonSecondaryConfig,
    this.onClose,
    this.onShow,
    this.onDismiss,
  });

  ModalConfirmationDialogConfigs copyWith({
    String? title,
    Widget? customTitleWidget,
    String? message,
    Widget? customMessageWidget,
    bool? isVisibleIcon,
    Widget? customIconWidget,
    double? iconSize,
    bool? isShowTitle,
    bool? isVisibleCloseButton,
    bool? barrierDismissible,
    ButtonConfigs? buttonPrimaryConfig,
    ButtonConfigs? buttonSecondaryConfig,
    Function()? onClose,
    Function()? onShow,
    Function()? onDismiss,
  }) {
    return ModalConfirmationDialogConfigs(
      title: title ?? this.title,
      customTitleWidget: customTitleWidget ?? this.customTitleWidget,
      message: message ?? this.message,
      customMessageWidget: customMessageWidget ?? this.customMessageWidget,
      isVisibleIcon: isVisibleIcon ?? this.isVisibleIcon,
      customIconWidget: customIconWidget ?? this.customIconWidget,
      iconSize: iconSize ?? this.iconSize,
      isShowTitle: isShowTitle ?? this.isShowTitle,
      isVisibleCloseButton: isVisibleCloseButton ?? this.isVisibleCloseButton,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      buttonPrimaryConfig: buttonPrimaryConfig ?? this.buttonPrimaryConfig,
      buttonSecondaryConfig:
          buttonSecondaryConfig ?? this.buttonSecondaryConfig,
      onClose: onClose ?? this.onClose,
      onShow: onShow ?? this.onShow,
      onDismiss: onDismiss ?? this.onDismiss,
    );
  }

  bool get isShowTitle$ => isShowTitle ?? true;
  bool get isVisibleCloseButton$ => isVisibleCloseButton ?? true;
  bool get barrierDismissible$ => barrierDismissible ?? true;
}
