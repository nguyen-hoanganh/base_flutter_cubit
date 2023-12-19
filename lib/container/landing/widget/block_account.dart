import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_confirmation_dialog/modal_confirmation_dialog.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/common/utils/utils.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

Future<void> onShowPopupErrorLogin({
  bool? inActiveAccount,
  bool? disabledAccount,
  String? errorCode,
  String? errorMessage,
}) async {
  Widget icon = Assets.svgs.icWarning.svg();
  String title = AppLocalizations.current.titleBlockAcc;
  Color colorTitle = CommonColors.accentColor1;

  if (inActiveAccount == true) {
    icon = Assets.svgs.icError.svg();
    title = AppLocalizations.current.inActiveAccount;
    colorTitle = CommonColors.neutralColor2;
  }

  ModalConfirmationDialog(
    configs: ModalConfirmationDialogConfigs(
      isVisibleCloseButton: false,
      customIconWidget: icon,
      customTitleWidget: Column(
        children: [
          Gap(12.s),
          Text(
            title,
            textAlign: TextAlign.center,
            style: CommonTextStyle.bodyB2.copyWith(
              color: colorTitle,
            ),
          ),
          Gap(4.s)
        ],
      ),
      customMessageWidget: Text(
        "$errorCode - $errorMessage",
        textAlign: TextAlign.center,
        style:
            CommonTextStyle.bodyB4.copyWith(color: CommonColors.primaryColor1),
      ),
      buttonPrimaryConfig: ButtonConfigs(
        state: ButtonState.default$,
        type: ButtonType.primary,
        content: AppLocalizations.current.contactCS,
        contentStyle: CommonTextStyle.bodyB2.copyWith(
          color: CommonColors.neutralColor7,
        ),
        onTap: ((() async {
          //todo something
          Utils.contactCustomerService();
        })),
      ),
      buttonSecondaryConfig: ButtonConfigs(
        state: ButtonState.default$,
        type: ButtonType.secondary,
        content: disabledAccount == true
            ? AppLocalizations.current.exit
            : AppLocalizations.current.cancel,
        onTap: () {
          //todo something
        },
      ),
    ),
  ).show();
}
