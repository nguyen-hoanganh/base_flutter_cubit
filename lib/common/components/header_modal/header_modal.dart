import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

part 'models/header_modal_configs.dart';

class HeaderModal extends StatelessWidget {
  final HeaderModalConfigs configs;

  const HeaderModal({
    Key? key,
    required this.configs,
  }) : super(key: key);

  Widget get _shape {
    return Padding(
      padding: EdgeInsets.all(4.s),
      child: Container(
        height: 3.s,
        width: 40.s,
        decoration: BoxDecoration(
          color: configs.colorShape ?? CommonColors.primaryColor1,
          borderRadius: BorderRadius.all(
            Radius.circular(4.s),
          ),
        ),
      ),
    );
  }

  List<Widget> get _rightWidget {
    if (configs.rightWidget != null) {
      return [Gap(12.s), configs.rightWidget!];
    } else {
      return [Gap(0.s)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: configs.isShowTitle ? 67.s : null,
      width: double.infinity,
      decoration: BoxDecoration(
        color: configs.isBackground
            ? CommonColors.neutralColor7
            : Colors.transparent,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.s),
        ),
      ),
      padding: EdgeInsets.only(
        left: 32.s,
        right: 32.s,
        top: 8.s,
      ),
      child: Column(
        children: [
          _shape,
          Gap(8.s),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: configs.isShowTitle,
                child: Text(
                  configs.title,
                  style: CommonTextStyle.bodyB2
                      .copyWith(color: CommonColors.primaryColor1),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ..._rightWidget,
            ],
          ),
        ],
      ),
    );
  }
}
