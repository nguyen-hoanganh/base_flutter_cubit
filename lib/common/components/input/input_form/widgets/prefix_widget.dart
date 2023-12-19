part of '../input_form.dart';

class _PrefixWidget extends StatelessWidget {
  final InputFormConfigs configs;

  const _PrefixWidget({
    Key? key,
    required this.configs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final disabledTap = !configs.enabled || configs.onPrefixIconTap == null;

    return Visibility(
      visible: configs.prefixIcon != null,
      child: TouchableOpacity(
        onTap: configs.onPrefixIconTap,
        opacityWhenDisabled: false,
        disabled: disabledTap,
        child: configs.prefixIcon ?? const SizedBox.shrink(),
      ),
    );
  }
}
