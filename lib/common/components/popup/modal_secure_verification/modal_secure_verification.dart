import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/gesture_detector/gesture_detector_opacity/gesture_detector_opacity.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_dialog/modal_dialog.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

part 'models/modal_secure_verification_configs.dart';

class ModalSecureVerification {
  final ModalSecureVerificationConfigs configs;
  ModalSecureVerification({
    required this.configs,
  });

  Widget _buildLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildHeader(),
        Gap(12.s),
        _buildContent(),
        Gap(12.s),
        _buildButton(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Visibility(
          visible: configs.isVisibleCloseButton$,
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetectorOpacity(
              configs: GestureDetectorConfigs(
                onTap: () => AppRouter.router.pop(),
                child: Padding(
                  padding: EdgeInsets.only(left: 12.s),
                  child: SizedBox(
                    width: 24.s,
                    height: 24.s,
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 24.s,
                        color: CommonColors.primaryColor1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (!configs.isVisibleCloseButton$) Gap(36.s),
        if (configs.isHideLogo == null)
          Assets.images.logoCBP.image(width: 145.s),
        Gap(12.s),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 13.s),
          color: CommonColors.accentColor1,
          child: Center(
            child: Text(
              "Secure Verification",
              style: CommonTextStyle.bodyB2
                  .copyWith(color: CommonColors.neutralColor7),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (configs.isShowTitle == true)
          Text(
            configs.title ?? "",
            style: CommonTextStyle.bodyB2.copyWith(
              color: configs.titleColor ?? CommonColors.neutralColor2,
            ),
            textAlign: TextAlign.center,
          ),
        if (configs.isShowTitle == true) Gap(12.s),
        if (configs.showAmount == true)
          Text(
            "MYR ${configs.amount ?? ''}",
            style: CommonTextStyle.bodyB1
                .copyWith(color: CommonColors.secondaryColor1),
          ),
        if (configs.showAmount == true) Gap(12.s),
        if (configs.showTime == true)
          Text(
            configs.time ??
                DateFormat('dd/MM/yyyy - HH:mm').format(DateTime.now()),
            style: CommonTextStyle.supportFontSubtitle3
                .copyWith(color: CommonColors.neutralColor3),
          ),
        if (configs.showTime == true) Gap(12.s),
        if (configs.showIcon == true)
          configs.icon ?? Assets.images.success.image(scale: 2),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.s),
          child: configs.contentLayoutWidget ?? Container(),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.s, left: 16.s, right: 16.s),
      child: Visibility(
        visible: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button(
              configs: configs.buttonPrimaryConfig ??
                  ButtonConfigs(
                    state: ButtonState.default$,
                    type: ButtonType.primary,
                    content: configs.titleButtonPrimary ?? "Approve",
                    onTap: () async {
                      configs.onTapButtonPrimary?.call();
                      // final response = await onExecute("");
                      // if (response == "00") {
                      //   onExecuteDone?.call();
                      // } else {
                      //   onExecuteError?.call(response);
                      // }
                      // AppRouter.router.pop();
                    },
                  ),
            ),
            if (configs.typeButton == TypeButton.twoButton) Gap(12.s),
            if (configs.typeButton == TypeButton.twoButton)
              Button(
                configs: configs.buttonSecondaryConfig ??
                    ButtonConfigs(
                      state: ButtonState.default$,
                      type: ButtonType.secondary,
                      content: configs.titleButtonSecondary ?? "Reject",
                      onTap: () {
                        configs.onTapButtonSecondary?.call();
                        // AppRouter.router.pop();
                      },
                    ),
              ),
          ],
        ),
      ),
    );
  }

  Future<T?> show<T extends Object?>({BuildContext? context}) async {
    return _ModalSecureVerification(
      configs: _ModalSecureVerification.setDefaultValuesToConfigs(
        ModalDialogConfigs().copyWith(customLayoutWidget: _buildLayout()),
      ),
    ).show(context: context);
  }
}

class _ModalSecureVerification extends ModalDialog {
  _ModalSecureVerification({
    required ModalDialogConfigs configs,
  }) : super(
          configs: ModalDialogConfigs(
            padding: const EdgeInsets.all(0),
            customLayoutWidget: configs.customLayoutWidget,
            margin: EdgeInsets.symmetric(vertical: 32.s, horizontal: 24.s),
          ),
        );

  static ModalDialogConfigs setDefaultValuesToConfigs(
    ModalDialogConfigs passedConfigs,
  ) {
    return passedConfigs.copyWith();
  }
}
