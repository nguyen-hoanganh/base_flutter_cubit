part of '../input_form.dart';

class _ErrorCaptionWidget extends StatelessWidget {
  final InputFormConfigs configs;

  const _ErrorCaptionWidget({
    Key? key,
    required this.configs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text =
        configs.hasError ? configs.errorText! : (configs.captionText ?? "");
    final padding =
        configs.hasError ? configs.errorPadding : configs.captionPadding;
    final maxLines =
        configs.hasError ? configs.errorMaxLines : configs.captionMaxLines;
    final style =
        configs.hasError ? configs.errorTextStyle : configs.captionTextStyle;

    return Visibility(
      visible: text.isNotEmpty,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          text,
          maxLines: maxLines <= 0 ? null : maxLines,
          style: style,
        ),
      ),
    );
  }
}
