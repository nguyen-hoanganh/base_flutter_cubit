import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
part 'models/check_box_configs.dart';

class CheckBoxButton extends StatelessWidget {
  const CheckBoxButton({Key? key, required this.configs}) : super(key: key);
  final CheckBoxConfigs configs;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Checkbox(
          value: configs.value$,
          onChanged: (value) {
            setState(() => configs.value = value);
            configs.onChange?.call(configs.value$);
          },
          shape: const CircleBorder(),
          activeColor: CommonColors.primaryColor2,
          checkColor: CommonColors.neutralColor7,
          side: BorderSide(
            color: CommonColors.primaryColor2,
            width: 2.s,
          ),
        );
      },
    );
  }
}
