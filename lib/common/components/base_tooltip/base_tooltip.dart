import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

part 'models/base_tooltip_configs.dart';

class BaseTooltip extends StatefulWidget {
  final BaseTooltipConfigs configs;

  BaseTooltip({
    Key? key,
    required BaseTooltipConfigs configs,
  })  : configs = setDefaultValuesToConfigs(configs),
        super(key: key);

  static BaseTooltipConfigs setDefaultValuesToConfigs(
    BaseTooltipConfigs passedConfigs,
  ) {
    return passedConfigs.copyWith();
  }

  @override
  State<BaseTooltip> createState() => BaseTooltipState();
}

class BaseTooltipState extends State<BaseTooltip> {
  final tooltipController = JustTheController();

  @override
  void initState() {
    tooltipController.addListener(() {
      if (tooltipController.value == TooltipStatus.isShowing) {
        if (widget.configs.duration$ != const Duration(seconds: 0)) {
          Future.delayed(widget.configs.duration$, () {
            tooltipController.hideTooltip();
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      triggerMode: TooltipTriggerMode.tap,
      controller: tooltipController,
      preferredDirection: axisDirection,
      tailLength: 8.s,
      tailBaseWidth: 16.s,
      isModal: true,
      borderRadius: const BorderRadius.all(
        Radius.circular(0),
      ),
      backgroundColor: widget.configs.backgroundColor$,
      content: _buildContentWidget(),
      child: widget.configs.child ?? const SizedBox.shrink(),
    );
  }

  Widget _buildContentWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.s, vertical: 8.s),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 18.s,
          minWidth: 80.s,
        ),
        child: widget.configs.content,
      ),
    );
  }

  AxisDirection get axisDirection {
    switch (widget.configs.layout$) {
      case BaseTooltipLayout.top:
        return AxisDirection.up;
      default:
        return AxisDirection.down;
    }
  }
}
