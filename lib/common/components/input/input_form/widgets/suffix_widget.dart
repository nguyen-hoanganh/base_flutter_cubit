part of '../input_form.dart';

class _SuffixWidget extends StatelessWidget {
  final InputFormConfigs configs;

  const _SuffixWidget({
    Key? key,
    required this.configs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final disabledTap = !configs.canTapSuffixOnDisable &&
        (!configs.enabled || configs.onSuffixIconTap == null);

    return Visibility(
      visible: configs.suffixIcon != null,
      child: TouchableOpacity(
        onTap: configs.onSuffixIconTap,
        opacityWhenDisabled: false,
        disabled: disabledTap,
        child: configs.suffixIcon ?? const SizedBox.shrink(),
      ),
    );
  }
}
