import 'package:cbp_mobile_app_flutter/common/components/base_content/base_item.dart';
import 'package:cbp_mobile_app_flutter/common/components/base_decoration.dart';
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final int maxLine;
  final VoidCallback? onTap;
  final VoidCallback? tapLeftWidget;
  final VoidCallback? tapRightWidget;
  final Widget? childLeftWidget;
  final Widget? childRightWidget;
  final bool? leftWidget;

  const NavigationButton({
    super.key,
    this.maxLine = 1,
    this.onTap,
    this.tapLeftWidget,
    this.tapRightWidget,
    this.childLeftWidget,
    this.leftWidget,
    this.childRightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BaseItem.textWithIcon(
        maxLine: maxLine,
        decoration: BaseDecorations.shadow4,
        twoIcon: true,
        leftIcon: leftWidget,
        childLeftIcon: childLeftWidget != null
            ? GestureDetector(onTap: tapLeftWidget, child: childLeftWidget)
            : const SizedBox(),
        childRightIcon: childRightWidget != null
            ? GestureDetector(onTap: tapRightWidget, child: childRightWidget)
            : const SizedBox(),
      ),
    );
  }
}
