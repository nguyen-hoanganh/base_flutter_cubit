import 'package:cbp_mobile_app_flutter/common/components/base_content/text_content_horizontal.dart';
import 'package:cbp_mobile_app_flutter/common/components/base_divider/a_divider_configs.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class CustomDivider extends StatelessWidget {
  final ADividerConfigs configs;
  final Widget? child;

  CustomDivider({Key? key, required ADividerConfigs configs, this.child})
      : configs = setDefaultValuesToConfigs(configs),
        super(key: key);

  static ADividerConfigs setDefaultValuesToConfigs(
    ADividerConfigs passedConfigs,
  ) {
    return passedConfigs.copyWith(
      width: passedConfigs.width ?? double.infinity,
      strokeWidth: passedConfigs.strokeWidth ?? 1,
      color: passedConfigs.color ?? passedConfigs.color,
    );
  }

  CustomDivider.information({super.key})
      : configs = const ADividerConfigs(),
        child = Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.s, vertical: 32.s),
          child: Column(
            children: [
              TextContentHorizontal.bodyTittle4(),
              SizedBox(height: 45.s),
              TextContentHorizontal.scriptSubtitle1(),
            ],
          ),
        );

  @override
  Widget build(BuildContext context) {
    switch (configs.type$) {
      case ADividerType.line:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (configs.isShowSpacingTop$) Gap(configs.spacingTop$),
            Container(
              width: configs.width,
              height: configs.strokeWidth,
              color: configs.color$,
            ),
            if (configs.isShowSpacingBottom$) Gap(configs.spacingBottom$),
          ],
        );
      case ADividerType.dash:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // if (configs.isShowSpacingTop$) Gap(configs.spacingTop$),
            SizedBox(
              width: configs.width,
              child: DottedBorder(
                customPath: (size) => Path()
                  ..moveTo(0, 0)
                  ..lineTo(size.width, 0),
                strokeWidth: configs.strokeWidth ?? 1,
                padding: EdgeInsets.zero,
                dashPattern: const [4, 4],
                color: configs.color$,
                child: const SizedBox.shrink(),
              ),
            ),
            // if (configs.isShowSpacingBottom$) Gap(configs.spacingBottom$),
          ],
        );
      case ADividerType.information:
        return DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(1),
          dashPattern: const [5, 5],
          color: Colors.grey,
          strokeWidth: 2,
          child: child ?? const SizedBox.shrink(),
        );
      default:
        return SizedBox(
          width: configs.width,
          height: configs.spacingBottom$,
          child: const SizedBox.shrink(),
        );
    }
  }
}
