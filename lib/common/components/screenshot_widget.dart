import 'package:cbp_mobile_app_flutter/common/components/base_result/base_result.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class ScreenShotWidget extends StatefulWidget {
  const ScreenShotWidget({
    Key? key,
    required this.params,
    // required this.content,
    this.executeTime,
  }) : super(key: key);
  // final Widget content;
  final BaseResultConfigs params;
  final String? executeTime;

  @override
  State<ScreenShotWidget> createState() => ScreenShotWidgetState();
}

class ScreenShotWidgetState extends State<ScreenShotWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      decoration: BoxDecoration(
        gradient: CommonColors.gradient3,
      ),
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Assets.images.imageBackground.image(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.s, vertical: 50.s),
            child: Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(32.s),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 24.s,
                      horizontal: 16.s,
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.s,
                          color: const Color(0xFFE0ECFF),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      shadows: [
                        BoxShadow(
                          color: const Color(0x4CA0B9DF),
                          blurRadius: 4,
                          offset: Offset(0, 4.s),
                          spreadRadius: 0.s,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Assets.images.logoCBP.image(width: 145.s),
                        Gap(12.s),
                        Text(
                          widget.params.title,
                          style: CommonTextStyle.bodyB2.copyWith(
                            color: widget.params.isSuccess
                                ? CommonColors.primaryColor1
                                : CommonColors.accentColor1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (!widget.params.isSuccess &&
                            widget.params.errorDescription != '')
                          Column(
                            children: [
                              Gap(4.s),
                              Text(
                                "${widget.params.errorCode} - ${widget.params.errorDescription$}",
                                style: CommonTextStyle.scriptSubtitle1.copyWith(
                                  color: CommonColors.secondaryColor2,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        Gap(4.s),
                        if (widget.params.amount != null)
                          Text(
                            "MYR ${widget.params.amount}",
                            style: CommonTextStyle.bodyB1.copyWith(
                              color: CommonColors.secondaryColor1,
                            ),
                          ),
                        Gap(4.s),
                        Text(
                          widget.executeTime ?? "",
                          style: CommonTextStyle.supportFontSubtitle3
                              .copyWith(color: CommonColors.neutralColor3),
                        ),
                        Gap(12.s),
                        if (widget.params.isSuccess)
                          Assets.images.success.image(
                            width: 80.s,
                            height: 80.s,
                          ),
                        if (!widget.params.isSuccess)
                          Assets.images.failure.image(
                            width: 80.s,
                            height: 80.s,
                          ),
                        Gap(12.s),
                        widget.params.contentLayoutWidget ?? Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
