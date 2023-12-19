part of '../modal_secure_verification.dart';

enum TypeButton {
  singleButton,
  twoButton,
}

class ModalSecureVerificationConfigs {
  final bool? isHideLogo;
  final String? title;
  final Color? titleColor;
  final Widget? customTitleWidget;

  final bool? isShowTitle;
  final bool? isVisibleCloseButton;
  final bool? barrierDismissible;

  final bool? showAmount;
  final String? amount;

  final bool? showTime;
  final String? time;

  final bool? showIcon;
  final Widget? icon;

  final ButtonConfigs? buttonPrimaryConfig;
  final String? titleButtonPrimary;
  final Function()? onTapButtonPrimary;
  final ButtonConfigs? buttonSecondaryConfig;
  final String? titleButtonSecondary;
  final Function()? onTapButtonSecondary;

  final Function()? onShow;
  final Function()? onDismiss;

  final Widget? contentLayoutWidget;
  final TypeButton typeButton;

  ModalSecureVerificationConfigs({
    this.isHideLogo,
    this.title,
    this.titleColor,
    this.customTitleWidget,
    this.isShowTitle,
    this.isVisibleCloseButton,
    this.barrierDismissible,
    this.showAmount,
    this.amount,
    this.showTime,
    this.time,
    this.showIcon,
    this.icon,
    this.buttonPrimaryConfig,
    this.titleButtonPrimary,
    this.onTapButtonPrimary,
    this.buttonSecondaryConfig,
    this.titleButtonSecondary,
    this.onTapButtonSecondary,
    this.onShow,
    this.onDismiss,
    this.contentLayoutWidget,
    this.typeButton = TypeButton.twoButton,
  });

  ModalSecureVerificationConfigs copyWith({
    bool? isHideLogo,
    String? title,
    Color? titleColor,
    Widget? customTitleWidget,
    bool? isShowTitle,
    bool? isVisibleCloseButton,
    bool? barrierDismissible,
    bool? showAmount,
    String? amount,
    bool? showTime,
    String? time,
    bool? showIcon,
    Widget? icon,
    ButtonConfigs? buttonPrimaryConfig,
    String? titleButtonPrimary,
    Function()? onTapButtonPrimary,
    ButtonConfigs? buttonSecondaryConfig,
    String? titleButtonSecondary,
    Function()? onTapButtonSecondary,
    Function()? onShow,
    Function()? onDismiss,
    Widget? contentLayoutWidget,
    TypeButton? typeButton,
  }) {
    return ModalSecureVerificationConfigs(
      isHideLogo: isHideLogo ?? this.isHideLogo,
      title: title ?? this.title,
      titleColor: titleColor ?? this.titleColor,
      customTitleWidget: customTitleWidget ?? this.customTitleWidget,
      isShowTitle: isShowTitle ?? this.isShowTitle,
      isVisibleCloseButton: isVisibleCloseButton ?? this.isVisibleCloseButton,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      showTime: showTime ?? this.showTime,
      time: time ?? this.time,
      showIcon: showIcon ?? this.showIcon,
      icon: icon ?? this.icon,
      showAmount: showAmount ?? this.showAmount,
      amount: amount ?? this.amount,
      buttonPrimaryConfig: buttonPrimaryConfig ?? this.buttonPrimaryConfig,
      titleButtonPrimary: titleButtonPrimary ?? this.titleButtonPrimary,
      onTapButtonPrimary: onTapButtonPrimary ?? this.onTapButtonPrimary,
      buttonSecondaryConfig:
          buttonSecondaryConfig ?? this.buttonSecondaryConfig,
      titleButtonSecondary: titleButtonSecondary ?? this.titleButtonSecondary,
      onTapButtonSecondary: onTapButtonSecondary ?? this.onTapButtonSecondary,
      onShow: onShow ?? this.onShow,
      onDismiss: onDismiss ?? this.onDismiss,
      contentLayoutWidget: contentLayoutWidget ?? this.contentLayoutWidget,
      typeButton: typeButton ?? this.typeButton,
    );
  }

  bool get isHideLogo$ => isHideLogo ?? true;
  bool get isShowTitle$ => isShowTitle ?? true;
  bool get isVisibleCloseButton$ => isVisibleCloseButton ?? true;
  bool get barrierDismissible$ => barrierDismissible ?? true;
}
