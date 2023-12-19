import 'package:cbp_mobile_app_flutter/common/theme/box_shadow.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

part 'models/card_navigation_vertical_configs.dart';

class CardNavigationVertical extends StatelessWidget {
  final CardNavigationVerticalConfigs configs;
  const CardNavigationVertical({required this.configs, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CommonColors.neutralColor7,
        borderRadius: BorderRadius.circular(4.s),
        boxShadow: configs.hasBoxShadow$
            ? [
                CommonBoxShadow.shadowLight1,
              ]
            : [],
      ),
      child: _buildHeader,
    );
  }

  Widget get _buildHeader => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: configs.onTap,
        child: Container(
          padding: configs.padding$,
          decoration: BoxDecoration(
            color: configs.backgroundHeader$,
            borderRadius: BorderRadius.circular(4.s),
            boxShadow: configs.hasBoxShadow$
                ? [
                    CommonBoxShadow.shadowLight1,
                  ]
                : [],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (configs.showPrefix$) ...[
                configs.prefixIcon ?? const SizedBox.shrink(),
                Gap(12.s),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      configs.title ?? '',
                      style: configs.titleStyle$,
                    ),
                    if (configs.showSubtitle$) ...[
                      Gap(4.s),
                      configs.customSub ??
                          Text(
                            configs.subTitle ?? '',
                            style: configs.subTitleStyle$,
                          )
                    ]
                  ],
                ),
              ),
              Assets.svgs.arrowDown.svg(
                color: configs.color$ == CardNavigationVerticalColorType.primary
                    ? CommonColors.primaryColor1
                    : CommonColors.neutralColor7,
              ),
            ],
          ),
        ),
      );
}
