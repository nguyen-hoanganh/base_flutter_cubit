import 'package:cbp_mobile_app_flutter/common/components/button/gesture_detector/gesture_detector_bounceable/gesture_detector_bounceable.dart';
import 'package:cbp_mobile_app_flutter/common/theme/box_shadow.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

part 'models/expandable_widget_configs.dart';

class ExpandableWidget extends StatefulWidget {
  final ExpandableWidgetConfigs configs;
  const ExpandableWidget({required this.configs, super.key});

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  late ExpandableController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.configs.controller$
      ..value = widget.configs.initialValue$;
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.configs.controller == null) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: true,
        scrollOnCollapse: false,
        child: Container(
          decoration: BoxDecoration(
            color: CommonColors.neutralColor7,
            borderRadius: BorderRadius.circular(4.s),
            boxShadow: widget.configs.hasBoxShadow$
                ? [
                    CommonBoxShadow.shadowLight1,
                  ]
                : [],
          ),
          child: Column(
            children: [
              _buildHeader,
              Expandable(
                controller: _controller,
                collapsed: const SizedBox.shrink(),
                expanded: Padding(
                  padding: widget.configs.padding$,
                  child: Column(
                    children: [
                      if (widget.configs.child != null) widget.configs.child!,
                      if (widget.configs.showClose$) _buildCloseExpand,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildCloseExpand => GestureDetectorBounceable(
        onTap: () {
          _controller.value = false;
          setState(() {});
        },
        child: Assets.svgs.arrowUp.svg(),
      );

  Widget get _buildHeader => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (widget.configs.onTapTitle == null) {
            _controller.toggle();
            setState(() {});
          }
        },
        child: Container(
          padding: widget.configs.padding$,
          decoration: BoxDecoration(
            color: widget.configs.backgroundHeader$,
            borderRadius: BorderRadius.circular(4.s),
            boxShadow: widget.configs.hasBoxShadow$
                ? [
                    CommonBoxShadow.shadowLight1,
                  ]
                : [],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: widget.configs.onTapTitle,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.configs.showPrefix$) ...[
                        widget.configs.prefixIcon ?? const SizedBox.shrink(),
                        Gap(12.s),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.configs.title ?? '',
                              style: widget.configs.titleStyle$,
                            ),
                            if (widget.configs.showSubtitle$) ...[
                              Gap(4.s),
                              Text(
                                widget.configs.subTitle ?? '',
                                style: widget.configs.subTitleStyle$,
                              )
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _controller.toggle();
                  setState(() {});
                },
                child: ValueListenableBuilder<bool>(
                  valueListenable: _controller,
                  builder: ((context, value, child) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        color: widget.configs.color$ ==
                                ExpandableWidgetColorType.primary
                            ? CommonColors.secondaryColor5.withOpacity(
                                value ? 1 : 0,
                              )
                            : CommonColors.accentColor4.withOpacity(
                                value ? 1 : 0,
                              ),
                        child: Assets.svgs.arrowDown.svg(
                          color: widget.configs.color$ ==
                                  ExpandableWidgetColorType.primary
                              ? CommonColors.primaryColor1
                              : CommonColors.neutralColor7,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      );
}
