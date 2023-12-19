import 'package:cbp_mobile_app_flutter/common/components/base_divider/a_divider_configs.dart';
import 'package:cbp_mobile_app_flutter/common/components/base_divider/a_divider_private.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
part 'models/information_configs.dart';

class Information extends StatelessWidget {
  const Information({
    Key? key,
    required this.configs,
  }) : super(key: key);

  final InformationConfigs configs;

  static InformationConfigs setDefaultValuesToConfigs(
    InformationConfigs passedConfigs,
  ) {
    return passedConfigs.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: configs.leadingFlex,
              child: Text(
                configs.leadingText ?? "",
                style: getLeadingTextStyle(),
              ),
            ),
            SizedBox(width: 8.s),
            Expanded(
              flex: configs.trailingFlex,
              child: configs.customTrailing ??
                  Text(
                    configs.trailingText ?? "",
                    textAlign: TextAlign.right,
                    style: getTrailingTextStyle(),
                  ),
            )
          ],
        ),
        if (configs.isShowDivider == true) _buildDivider(),
      ],
    );
  }

  TextStyle getLeadingTextStyle() {
    if (configs.layout == InformationLayout.titleBigger) {
      if (configs.contentTextSize == InformationTextSize.l) {
        return configs.leadingStyle$.copyWith(fontSize: 18.s);
      } else if (configs.contentTextSize == MContentHorizontalTextSize.m) {
        return configs.leadingStyle$.copyWith(fontSize: 16.s);
      } else {
        return configs.leadingStyle$.copyWith(fontSize: 14.s);
      }
    } else if (configs.layout == InformationLayout.titleSmaller) {
      if (configs.contentTextSize == InformationTextSize.l) {
        return configs.leadingStyle$.copyWith(fontSize: 16.s);
      } else if (configs.contentTextSize == InformationTextSize.m) {
        return configs.leadingStyle$.copyWith(fontSize: 14.s);
      } else {
        return configs.leadingStyle$.copyWith(fontSize: 12.s);
      }
    } else {
      if (configs.contentTextSize == InformationTextSize.l) {
        return configs.leadingTextStyle ??
            configs.leadingStyle$.copyWith(
              fontSize: 16.s,
              // color: themeData.color.textNeutralSub2,
            );
      } else if (configs.contentTextSize == InformationTextSize.m) {
        return configs.leadingTextStyle ??
            configs.leadingStyle$.copyWith(
              fontSize: 14.s,
              // color: themeData.color.textNeutralSub2,
            );
      } else {
        return configs.leadingTextStyle ??
            configs.leadingStyle$.copyWith(
              fontSize: 12.s,
              // color: themeData.color.textNeutralSub2,
            );
      }
    }
  }

  TextStyle getTrailingTextStyle() {
    if (configs.layout == InformationLayout.titleSmaller) {
      if (configs.mContentHorizontalTextSize == MContentHorizontalTextSize.l) {
        return configs.trailingStyle$.copyWith(fontSize: 18.s);
      } else if (configs.mContentHorizontalTextSize ==
          MContentHorizontalTextSize.m) {
        return configs.trailingStyle$.copyWith(fontSize: 16.s);
      } else {
        return configs.trailingStyle$.copyWith(fontSize: 14.s);
      }
    } else if (configs.layout == InformationLayout.titleBigger) {
      if (configs.mContentHorizontalTextSize == MContentHorizontalTextSize.l) {
        return configs.trailingStyle$.copyWith(fontSize: 16.s);
      } else if (configs.mContentHorizontalTextSize ==
          MContentHorizontalTextSize.m) {
        return configs.trailingStyle$.copyWith(fontSize: 14.s);
      } else {
        return configs.trailingStyle$.copyWith(fontSize: 12.s);
      }
    } else {
      if (configs.mContentHorizontalTextSize == MContentHorizontalTextSize.l) {
        return configs.trailingTextStyle ?? configs.trailingStyle$;
      } else if (configs.mContentHorizontalTextSize ==
          MContentHorizontalTextSize.m) {
        return configs.trailingTextStyle ?? configs.trailingStyle$;
      } else {
        return configs.trailingTextStyle ?? configs.trailingStyle$;
      }
    }
  }

  Widget _buildDivider() {
    return CustomDivider(
      configs: configs.aDividerConfigs ??
          ADividerConfigs(width: 0, spacingTop: 12.s),
    );
  }
}
