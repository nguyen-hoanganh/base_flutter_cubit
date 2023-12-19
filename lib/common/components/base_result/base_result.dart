import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/screenshot_widget.dart';
import 'package:cbp_mobile_app_flutter/common/screen/base_screen.dart';
import 'package:cbp_mobile_app_flutter/common/screen/scaffold/base_scaffold.dart';
import 'package:cbp_mobile_app_flutter/common/screen/scaffold/base_scaffold_configs.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/error_code/error_code_localization.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

part 'base_result_configs.dart';

class BaseResult extends StatelessWidget {
  final BaseResultConfigs configs;

  BaseResult({
    Key? key,
    required BaseResultConfigs configs,
  })  : configs = setDefaultValuesToConfigs(configs),
        super(key: key);

  static BaseResultConfigs setDefaultValuesToConfigs(
    BaseResultConfigs passedConfigs,
  ) {
    return passedConfigs.copyWith();
  }

  final executeTime = DateFormat("dd/MM/yyyy - HH:mm").format(DateTime.now());
  final screenshotController = ScreenshotController();

  Future<bool> onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Screenshot(
            controller: screenshotController,
            child: ScreenShotWidget(
              params: configs,
              executeTime: executeTime,
            ),
          ),
        ),
        BaseScreen(
          onWillPop: onWillPop,
          scaffoldBuilder: () => BaseScaffold(
            configs: BaseScaffoldConfigs(
              body: SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Assets.images.imageBackground.image(),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.s,
                        horizontal: 24.s,
                      ),
                      child: Column(
                        children: [
                          _buildButtonTop(context),
                          Gap(32.s),
                          _buildBody(),
                          _buildButtonBottom(),
                          Gap(24.s),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonTop(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (configs.isShowMutilButtonTop == true)
          Row(
            children: [
              _buildActionButton(
                Assets.svgs.share,
                onTap: () {
                  configs.handleShare?.call(context, screenshotController);
                },
              ),
              Gap(8.s),
              _buildActionButton(
                Assets.svgs.cameraPhoto,
                onTap: () {
                  configs.handleCapture?.call(context, screenshotController);
                },
              ),
              Gap(8.s),
            ],
          ),
        _buildActionButton(
          Assets.svgs.homeLine,
          onTap: () {
            AppRouter.popUntilRoute(
              context,
              path: Routes.homeNamedPage,
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(SvgGenImage child, {void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.s, color: const Color(0xFFE0ECFF)),
            borderRadius: BorderRadius.circular(5),
          ),
          shadows: [
            BoxShadow(
              color: const Color(0x4CA0B9DF),
              blurRadius: 4.s,
              offset: Offset(0, 4.s),
              spreadRadius: 0,
            )
          ],
        ),
        padding: EdgeInsets.all(4.s),
        child: child.svg(
          width: 24.s,
          height: 24.s,
          color: CommonColors.primaryColor1,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: ListView(
        // mainAxisSize: MainAxisSize.min,
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
                side: BorderSide(width: 1.s, color: const Color(0xFFE0ECFF)),
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
                  configs.title,
                  style: CommonTextStyle.bodyB2.copyWith(
                    color: configs.isSuccess
                        ? CommonColors.primaryColor1
                        : CommonColors.accentColor1,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (!configs.isSuccess &&
                    configs.errorDescription?.isNotEmpty == true)
                  Column(
                    children: [
                      Gap(4.s),
                      Text(
                        "${configs.errorCode} - ${configs.errorDescription$}",
                        textAlign: TextAlign.center,
                        style: CommonTextStyle.scriptSubtitle1
                            .copyWith(color: CommonColors.secondaryColor2),
                      )
                    ],
                  ),
                Gap(4.s),
                if (configs.amount != null)
                  Text(
                    "MYR ${configs.amount}",
                    style: CommonTextStyle.bodyB1
                        .copyWith(color: CommonColors.secondaryColor1),
                  ),
                Gap(4.s),
                Text(
                  executeTime,
                  style: CommonTextStyle.supportFontSubtitle3
                      .copyWith(color: CommonColors.neutralColor3),
                ),
                Gap(12.s),
                if (configs.isSuccess)
                  Assets.images.success.image(
                    width: 80.s,
                    height: 80.s,
                  ),
                if (!configs.isSuccess)
                  Assets.images.failure.image(
                    width: 80.s,
                    height: 80.s,
                  ),
                Gap(12.s),
                configs.contentLayoutWidget ?? Container(),
              ],
            ),
          ),
          Gap(24.s),
        ],
      ),
    );
  }

  Widget _buildButtonBottom() {
    return Button(
      configs: ButtonConfigs(
        type: ButtonType.primary,
        content: configs.textButton,
        onTap: () {
          configs.handleButton?.call();
        },
      ),
    );
  }
}
