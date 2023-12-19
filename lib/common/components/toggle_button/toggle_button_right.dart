import 'package:cbp_mobile_app_flutter/common/components/toggle_button/models/toggle_right_config.dart';
import 'package:cbp_mobile_app_flutter/common/components/toggle_button/toggle_button.dart';
import 'package:cbp_mobile_app_flutter/common/theme/box_shadow.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme/text_style.dart';

class ToggleButtonRight extends StatelessWidget {
  const ToggleButtonRight({super.key, required this.configs});
  final ToggleRightConfig configs;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          decoration: BoxDecoration(
            color: configs.isShowBackground$
                ? CommonColors.neutralColor7
                : Colors.transparent,
            borderRadius:
                configs.isShowBackground$ ? BorderRadius.circular(4.s) : null,
            boxShadow: configs.isShowBackground$
                ? [
                    CommonBoxShadow.shadowLight1,
                  ]
                : null,
          ),
          padding: EdgeInsets.all(12.s),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  configs.text ?? '',
                  style: CommonTextStyle.bodyB4.copyWith(
                    color: CommonColors.primaryColor1,
                  ),
                ),
              ),
              SizedBox(
                width: 4.s,
              ),
              ToggleButton(
                configs: ToggleConfigs(
                  value: configs.value$,
                  onChange: (value) {
                    setState(() => configs.value = value);
                    configs.onChange?.call(configs.value$);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
