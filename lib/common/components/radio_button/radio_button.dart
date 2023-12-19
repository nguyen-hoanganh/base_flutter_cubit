import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme/common_colors.dart';

part 'models/radio_button_configs.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({super.key, required this.configs});
  final RadioButtonConfigs configs;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: () {
            if (configs.isDisabled ?? false) return;
            setState(() => configs.value = !configs.value$);
            configs.onChange?.call(configs.value$);
          },
          child: AnimatedContainer(
            decoration: BoxDecoration(
              color: CommonColors.neutralColor7,
              shape: BoxShape.circle,
              border: Border.all(
                color: CommonColors.primaryColor2,
                width: configs.value$ ? 5.s : 2.s,
              ),
            ),
            width: configs.width ?? 18.s,
            height: configs.height ?? 18.s,
            duration: const Duration(milliseconds: 300),
          ),
        );
      },
    );
  }
}
