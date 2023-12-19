import 'package:cbp_mobile_app_flutter/common/components/base_content/base_item.dart';
import 'package:cbp_mobile_app_flutter/common/components/base_decoration.dart';
import 'package:flutter/material.dart';

class VerticalTitleContentExpand extends StatefulWidget {
  final Widget? childLeftWidget;
  final Widget? rightWidget;
  final bool? leftWidget;

  const VerticalTitleContentExpand({
    Key? key,
    this.childLeftWidget,
    this.rightWidget,
    this.leftWidget,
  }) : super(key: key);

  @override
  State<VerticalTitleContentExpand> createState() =>
      _VerticalTitleContentExpandState();
}

class _VerticalTitleContentExpandState
    extends State<VerticalTitleContentExpand> {
  bool checkDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseItem.textWithIcon(
        title: 'Hoang Anh',
        content: 'Hoang Anh Test',
        maxLine: checkDown == false ? 1 : 2,
        decoration: BaseDecorations.shadow4,
        twoIcon: true,
        leftIcon: widget.leftWidget,
        childLeftIcon: widget.childLeftWidget ?? const SizedBox(),
        childRightIcon: GestureDetector(
          onTap: () {
            setState(() {
              checkDown = !checkDown;
            });
          },
          child: checkDown == false
              ? const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 12,
                )
              : const Icon(Icons.arrow_drop_down_sharp),
        ),
      ),
    );
  }
}
