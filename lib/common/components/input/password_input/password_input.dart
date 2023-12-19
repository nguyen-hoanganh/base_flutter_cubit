import 'package:cbp_mobile_app_flutter/common/components/input/normal_input/normal_input.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final NormalInputConfigs configs;

  const PasswordInput({
    super.key,
    required this.configs,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return NormalInput(
      configs: widget.configs.copyWith(
        suffixIcon: obscureText
            ? Assets.svgs.icEyeShut.svg()
            : Assets.svgs.icEyeOpen.svg(),
        isObscureText: obscureText,
        onSuffixIconTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
      ),
    );
  }
}
