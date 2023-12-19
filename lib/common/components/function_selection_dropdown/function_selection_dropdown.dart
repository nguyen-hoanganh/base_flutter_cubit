import 'package:cbp_mobile_app_flutter/common/theme/box_shadow.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

part 'models/function_selection_dropdown_configs.dart';

class FunctionSelectionDropdown extends StatelessWidget {
  final FunctionSelectionDropdownConfigs configs;
  const FunctionSelectionDropdown({
    required this.configs,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: configs.onTap,
      child: Container(
        padding: configs.padding$,
        decoration: BoxDecoration(
          color: CommonColors.neutralColor7,
          borderRadius: BorderRadius.circular(4.s),
          boxShadow: configs.hasBoxShadow$
              ? [
                  CommonBoxShadow.shadowLight1,
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (configs.showPrefix$) ...[
              SizedBox(
                width: 24.s,
                height: 24.s,
                child: Center(child: configs.prefixIcon),
              ),
              Gap(12.s),
            ],
            Expanded(
              child: configs.customTitle ??
                  Text(
                    configs.title ?? '',
                    style: configs.titleStyle$,
                  ),
            ),
            if (configs.showSuffix$) ...[
              Gap(12.s),
              SizedBox(
                width: 24.s,
                height: 24.s,
                child: Center(child: configs.suffixIcon$),
              )
            ],
          ],
        ),
      ),
    );
  }
}
