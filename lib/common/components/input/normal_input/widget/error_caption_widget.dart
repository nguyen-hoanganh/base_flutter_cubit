part of '../normal_input.dart';

class _ErrorCaptionWidget extends StatelessWidget {
  final NormalInputConfigs configs;

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
    final style = configs.hasError
        ? (configs.errorTextStyle ??
            CommonTextStyle.scriptSubtitle1
                .copyWith(color: CommonColors.accentColor2))
        : configs.captionTextStyle;

    return Visibility(
      visible: text.isNotEmpty,
      child: Padding(
        padding: padding ?? EdgeInsets.only(top: 4.s),
        child: Text(
          text,
          maxLines: maxLines <= 0 ? null : maxLines,
          style: style,
        ),
      ),
    );
  }
}
