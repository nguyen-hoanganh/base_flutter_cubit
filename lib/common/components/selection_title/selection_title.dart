import 'package:cbp_mobile_app_flutter/common/components/selection_title/models/selection_title_configs.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class SelectionTitle extends StatelessWidget {
  SelectionTitle({
    super.key,
    required SelectionTitleConfigs configs,
  }) : configs = setDefaultValuesToConfigs(configs);

  final SelectionTitleConfigs configs;

  static SelectionTitleConfigs setDefaultValuesToConfigs(
    SelectionTitleConfigs passedConfigs,
  ) {
    return passedConfigs;
    // return passedConfigs.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              configs.title ?? "",
              style: CommonTextStyle.bodyB2.copyWith(
                fontFamily: TextConstants.fontDINPro,
              ),
            ),
            Visibility(
              visible: configs.showSuffix == true,
              child: Container(
                margin: EdgeInsets.only(left: 12.s),
                child: configs.suffix,
              ),
            ),
          ],
        ),
        if (configs.isShowDivider == true) _buildDivider(),
      ],
    );
  }

  Widget _buildDivider() {
    return Gap(16.s);
  }
}
