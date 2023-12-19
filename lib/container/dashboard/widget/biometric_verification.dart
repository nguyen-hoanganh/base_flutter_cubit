import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_confirmation_dialog/modal_confirmation_dialog.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

Future<void> showPopupVerificationBiometric(
  BuildContext context, {
  bool? isDisable,
  Function()? onAgree,
  Function()? onDisAgree,
}) async {
  ModalConfirmationDialog(
    configs: ModalConfirmationDialogConfigs(
      isVisibleIcon: false,
      isVisibleCloseButton: false,
      customTitleWidget: Column(
        children: [
          Gap(12.s),
          Text(
            AppLocalizations.current.titleConfirmBiometric(
              isDisable == true ? 'Disable' : 'Enable',
            ),
            style: CommonTextStyle.bodyB2,
            textAlign: TextAlign.center,
          ),
          Gap(4.s)
        ],
      ),
      customMessageWidget: Column(
        children: [
          Text(
            AppLocalizations.current.contentConfirmBiometric,
            style: CommonTextStyle.scriptSubtitle1
                .copyWith(color: CommonColors.secondaryColor2),
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: AppLocalizations.current.pleaseContact,
                  style: CommonTextStyle.scriptSubtitle1
                      .copyWith(color: CommonColors.secondaryColor2),
                ),
                TextSpan(
                  text: AppLocalizations.current.contentBlock2,
                  style: CommonTextStyle.scriptSubtitle1
                      .copyWith(color: CommonColors.accentColor2),
                ),
                TextSpan(
                  text: AppLocalizations.current.contentBlock3,
                  style: CommonTextStyle.scriptSubtitle1
                      .copyWith(color: CommonColors.secondaryColor2),
                ),
              ],
            ),
          ),
        ],
      ),
      buttonPrimaryConfig: ButtonConfigs(
        state: ButtonState.default$,
        type: ButtonType.primary,
        contentStyle:
            CommonTextStyle.bodyB2.copyWith(color: CommonColors.neutralColor7),
        content: AppLocalizations.current.yes,
        onTap: (() {
          AppRouter.router.pop();
          onAgree?.call();
        }),
      ),
      buttonSecondaryConfig: ButtonConfigs(
        state: ButtonState.default$,
        type: ButtonType.secondary,
        contentStyle:
            CommonTextStyle.bodyB2.copyWith(color: CommonColors.primaryColor1),
        content: AppLocalizations.current.no,
        onTap: (() {
          onDisAgree?.call();
        }),
      ),
    ),
  ).show();
}
