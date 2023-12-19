part of '../modal_dialog.dart';

class ModalDialogConfigs {
  final String? title;
  final Widget? customTitleWidget;

  final String? message;
  final Widget? customMessageWidget;

  final bool? isVisibleIcon;
  final Widget? customIconWidget;
  final double? iconSize;

  final Widget? customLayoutWidget;

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool? isSafeArea;
  final bool? isVisibleCloseButton;
  final bool? isFullScreen;

  final List<ButtonConfigs>? buttonConfigs;

  final bool? barrierDismissible;
  final Color? barrierColor;

  final Function()? onClose;
  final Function()? onShow;
  final Function()? onDismiss;

  ModalDialogConfigs({
    this.title,
    this.customTitleWidget,
    this.message,
    this.customMessageWidget,
    this.isVisibleIcon,
    this.customIconWidget,
    this.iconSize,
    this.customLayoutWidget,
    this.margin,
    this.padding,
    this.isSafeArea,
    this.isVisibleCloseButton,
    this.isFullScreen,
    this.buttonConfigs,
    this.barrierDismissible,
    this.barrierColor,
    this.onClose,
    this.onShow,
    this.onDismiss,
  });

  ModalDialogConfigs copyWith({
    String? title,
    Widget? customTitleWidget,
    String? message,
    Widget? customMessageWidget,
    bool? isVisibleIcon,
    Color? iconColor,
    Widget? customIconWidget,
    double? iconSize,
    Widget? customLayoutWidget,
    EdgeInsets? margin,
    EdgeInsets? padding,
    bool? isSafeArea,
    bool? isVisibleCloseButton,
    bool? isFullScreen,
    List<ButtonConfigs>? buttonConfigs,
    bool? barrierDismissible,
    Color? barrierColor,
    Function()? onClose,
    Function()? onShow,
    Function()? onDismiss,
  }) {
    return ModalDialogConfigs(
      title: title ?? this.title,
      customTitleWidget: customTitleWidget ?? this.customTitleWidget,
      message: message ?? this.message,
      customMessageWidget: customMessageWidget ?? this.customMessageWidget,
      isVisibleIcon: isVisibleIcon ?? this.isVisibleIcon,
      customIconWidget: customIconWidget ?? this.customIconWidget,
      iconSize: iconSize ?? this.iconSize,
      customLayoutWidget: customLayoutWidget ?? this.customLayoutWidget,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      isSafeArea: isSafeArea ?? this.isSafeArea,
      isVisibleCloseButton: isVisibleCloseButton ?? this.isVisibleCloseButton,
      isFullScreen: isFullScreen ?? this.isFullScreen,
      buttonConfigs: buttonConfigs ?? this.buttonConfigs,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      barrierColor: barrierColor ?? this.barrierColor,
      onClose: onClose ?? this.onClose,
      onShow: onShow ?? this.onShow,
      onDismiss: onDismiss ?? this.onDismiss,
    );
  }

  List<ButtonConfigs> get actions$ => buttonConfigs ?? const [];
}

class SurfaceOverlayConfigs {
  final SurfaceConfigs? customConfigs;
  final Widget? child;

  SurfaceOverlayConfigs({
    this.customConfigs,
    this.child,
  });

  SurfaceOverlayConfigs copyWith({
    SurfaceConfigs? customConfigs,
    Widget? child,
  }) {
    return SurfaceOverlayConfigs(
      customConfigs: customConfigs ?? this.customConfigs,
      child: child ?? this.child,
    );
  }
}

class SurfaceConfigs {
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BoxDecoration? decoration;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;

  SurfaceConfigs({
    this.width,
    this.height,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    BoxConstraints? constraints,
    this.margin,
  })  : assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(decoration == null || decoration.debugAssertIsValid()),
        assert(constraints == null || constraints.debugAssertIsValid()),
        constraints = (width != null || height != null)
            ? constraints?.tighten(width: width, height: height) ??
                BoxConstraints.tightFor(width: width, height: height)
            : constraints;

  SurfaceConfigs copyWith({
    double? width,
    double? height,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    Color? color,
    BoxDecoration? decoration,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
  }) {
    return SurfaceConfigs(
      width: width ?? this.width,
      height: height ?? this.height,
      alignment: alignment ?? this.alignment,
      padding: padding ?? this.padding,
      color: color ?? this.color,
      decoration: decoration ?? this.decoration,
      constraints: constraints ?? this.constraints,
      margin: margin ?? this.margin,
    );
  }
}
