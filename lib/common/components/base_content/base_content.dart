import 'package:cbp_mobile_app_flutter/common/components/base_content/base_item.dart';
import 'package:cbp_mobile_app_flutter/common/components/base_decoration.dart';
import 'package:flutter/material.dart';

class BaseContent extends StatefulWidget {
  const BaseContent({Key? key}) : super(key: key);

  @override
  State<BaseContent> createState() => _BaseContentState();
}

class _BaseContentState extends State<BaseContent> {
  bool checkDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseItem.textWithIcon(
        maxLine: checkDown == false ? 1 : 2,
        decoration: BaseDecorations.shadow4,
        twoIcon: true,
        childLeftIcon: const Icon(Icons.add),
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
