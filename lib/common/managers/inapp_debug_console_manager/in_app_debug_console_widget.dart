import 'package:cbp_mobile_app_flutter/common/managers/inapp_debug_console_manager/draggable_widget.dart';
import 'package:cbp_mobile_app_flutter/common/managers/inapp_debug_console_manager/draggable_widget/anchoringposition.dart';
import 'package:cbp_mobile_app_flutter/common/managers/inapp_debug_console_manager/inapp_debug_console_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BubbleMenuWidget extends StatefulWidget {
  const BubbleMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BubbleMenuWidget> createState() => _BubbleMenuWidgetState();
}

class _BubbleMenuWidgetState extends State<BubbleMenuWidget>
    with SingleTickerProviderStateMixin {
  final dragController = DragController();

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final size = 60.s;

    return Stack(
      children: [
        DraggableWidget(
          dragController: dragController,
          bottomMargin: padding.bottom + size,
          horizontalSpace: 0,
          topMargin: padding.top,
          intialVisibility: true,
          onTap: () => InAppDebugConsoleManager.shared.show(context: context),
          normalShadow: const BoxShadow(color: Colors.transparent),
          draggingShadow: const BoxShadow(color: Colors.transparent),
          initialPosition: AnchoringPosition.topRight,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black.withOpacity(0.4),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 4.s),
              child: const Center(
                child: Icon(
                  Icons.settings,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
