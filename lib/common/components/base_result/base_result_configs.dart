part of 'base_result.dart';

class BaseResultConfigs {
  final String title;
  final bool isSuccess;
  final bool? showError;
  final String? errorCode;
  final String? errorDescription;
  final String? textButton;
  final bool? isShowMutilButtonTop;
  final String? amount;
  final Widget? contentLayoutWidget;
  final Function? handleButton;
  final Function(BuildContext context, ScreenshotController controller)?
      handleShare;
  final Function(BuildContext context, ScreenshotController controller)?
      handleCapture;

  BaseResultConfigs({
    required this.title,
    required this.isSuccess,
    this.textButton,
    this.isShowMutilButtonTop,
    this.amount,
    this.contentLayoutWidget,
    this.handleButton,
    this.handleShare,
    this.handleCapture,
    this.showError,
    this.errorCode,
    this.errorDescription,
  });

  BaseResultConfigs copyWith({
    String? title,
    bool? isSuccess,
    bool? showError,
    String? errorCode,
    String? errorDescription,
    String? textButton,
    bool? isShowMutilButtonTop,
    String? amount,
    Widget? contentLayoutWidget,
    Function? handleButton,
    Function(BuildContext context, ScreenshotController controller)?
        handleShare,
    Function(BuildContext context, ScreenshotController controller)?
        handleCapture,
  }) {
    return BaseResultConfigs(
      title: title ?? this.title,
      isSuccess: isSuccess ?? this.isSuccess,
      showError: showError ?? this.showError,
      errorCode: errorCode ?? this.errorCode,
      errorDescription: errorDescription ?? this.errorDescription,
      textButton: textButton ?? this.textButton,
      isShowMutilButtonTop: isShowMutilButtonTop ?? this.isShowMutilButtonTop,
      amount: amount ?? this.amount,
      contentLayoutWidget: contentLayoutWidget ?? this.contentLayoutWidget,
      handleButton: handleButton ?? this.handleButton,
      handleShare: handleShare ?? this.handleShare,
      handleCapture: handleCapture ?? this.handleCapture,
    );
  }

  bool get showError$ => showError ?? true;
  String get errorDescription$ =>
      errorDescription ?? ErrorCodeLocalization.getDefaultMessage(errorCode);
}
