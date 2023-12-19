import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_confirmation_dialog/modal_confirmation_dialog.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

Future<void> showPopupConfirmBiometric(
  Function handleSubmit,
) async {
  ModalConfirmationDialog(
    configs: ModalConfirmationDialogConfigs(
      isVisibleCloseButton: false,
      customIconWidget: Assets.svgs.icInfo.svg(),
      customTitleWidget: Column(
        children: [
          Gap(12.s),
          Text(
            AppLocalizations.current.titleQuestionLoginBiometric,
            style: CommonTextStyle.bodyB2,
            textAlign: TextAlign.center,
          ),
          Gap(4.s)
        ],
      ),
      customMessageWidget: Text(
        AppLocalizations.current.contentQuestionLoginBiometric,
        style: CommonTextStyle.scriptSubtitle1
            .copyWith(color: CommonColors.secondaryColor1),
        textAlign: TextAlign.center,
      ),
      buttonPrimaryConfig: ButtonConfigs(
        state: ButtonState.default$,
        type: ButtonType.primary,
        contentStyle:
            CommonTextStyle.bodyB2.copyWith(color: CommonColors.neutralColor7),
        content: AppLocalizations.current.yes,
        onTap: () {
          AppRouter.router.pop();
          handleSubmit();
        },
      ),
      buttonSecondaryConfig: ButtonConfigs(
        state: ButtonState.default$,
        type: ButtonType.secondary,
        contentStyle:
            CommonTextStyle.bodyB2.copyWith(color: CommonColors.primaryColor1),
        content: AppLocalizations.current.no,
        onTap: (() {
          AppRouter.router.pop();
        }),
      ),
    ),
  ).show();
}
