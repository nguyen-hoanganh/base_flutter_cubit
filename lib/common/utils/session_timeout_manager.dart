import 'dart:async';

import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/extensions/string_ext.dart';
import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../components/popup/modal_confirmation_dialog/modal_confirmation_dialog.dart';

class SessionTimeoutManager {
  Timer? _timer;

  // int _defaultSessionTimeoutSeconds = 5 * 60 - 17;

  final context = AppRouter.rootNavigatorKey.currentContext;
  void start() {
    if (AppManager.shared.sessionId.isNullOrEmptyString) return;
    if (_timer != null) return;

    _timer = Timer(
      Duration(seconds: (AppManager.shared.sessionTimeOut - 17)),
      _handle,
    );
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void resetRemain() {
    if (AppManager.shared.sessionId.isNullOrEmptyString) return;

    _timer?.cancel();
    _timer = Timer(
      Duration(seconds: (AppManager.shared.sessionTimeOut - 17)),
      _handle,
    );
  }

  void changeDefaultSessionTimeout(int? totalSecond) {
    if (totalSecond == null) return;
    AppManager.shared.sessionTimeOut = totalSecond;
    resetRemain();
  }

  void _handle() {
    stop();
    showPopupErrorCountDown();
    // Modular.getOrNull<CommonRepository>()?.doLogout(
    //   isShowDialogSessionInvalid: true,
    // );
  }

  void showPopupErrorCountDown() {
    ModalConfirmationDialog(
      configs: ModalConfirmationDialogConfigs(
        customIconWidget: Assets.svgs.icWarning.svg(),
        customTitleWidget: Column(
          children: [
            Gap(12.s),
            Text(
              'Timeout Alert',
              style: CommonTextStyle.bodyB2.copyWith(
                color: CommonColors.accentColor1,
              ),
            ),
            Gap(4.s)
          ],
        ),
        customMessageWidget: TweenAnimationBuilder(
          tween: IntTween(begin: 17, end: 0),
          duration: const Duration(seconds: 17),
          onEnd: () async {
            stop();
            Navigator.of(AppRouter.rootNavigatorKey.currentContext!).pop();
            AppRouter.router.pop;
            showPopupLogout();
          },
          builder: (BuildContext context, int value, Widget? child) {
            return Text(
              'Your session will expire in $value second(s). Click YES to continue or NO to logout',
              style: CommonTextStyle.scriptSubtitle1
                  .copyWith(color: CommonColors.secondaryColor2),
              textAlign: TextAlign.center,
            );
          },
        ),
        buttonPrimaryConfig: ButtonConfigs(
          state: ButtonState.default$,
          type: ButtonType.primary,
          content: 'Yes'.toUpperCase(),
          contentStyle: CommonTextStyle.bodyB2.copyWith(
            color: CommonColors.neutralColor7,
          ),
          onTap: ((() {
            Navigator.of(AppRouter.rootNavigatorKey.currentContext!).pop();
          })),
        ),
        buttonSecondaryConfig: ButtonConfigs(
          state: ButtonState.default$,
          type: ButtonType.secondary,
          content: 'No'.toUpperCase(),
          onTap: ((() {
            //todo something
          })),
        ),
      ),
    ).show();
  }

  void showPopupLogout() {
    ModalConfirmationDialog(
      configs: ModalConfirmationDialogConfigs(
        onClose: () {
          //todo something
        },
        customIconWidget: Assets.svgs.icInformation.svg(),
        customTitleWidget: Column(
          children: [
            Gap(12.s),
            Text(
              'Timeout',
              style: CommonTextStyle.bodyB2.copyWith(
                color: CommonColors.accentColor1,
              ),
            ),
            Gap(4.s)
          ],
        ),
        customMessageWidget: Text(
          'You have been log out due to inactivity. Please kindly log in again',
          style: CommonTextStyle.scriptSubtitle1
              .copyWith(color: CommonColors.secondaryColor2),
          textAlign: TextAlign.center,
        ),
        buttonPrimaryConfig: ButtonConfigs(
          state: ButtonState.default$,
          type: ButtonType.primary,
          content: 'Yes'.toUpperCase(),
          contentStyle: CommonTextStyle.bodyB2.copyWith(
            color: CommonColors.neutralColor7,
          ),
          onTap: () {
            //todo something
          },
        ),
      ),
    ).show();
  }
}
