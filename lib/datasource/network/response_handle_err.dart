import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_dialog/modal_dialog.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class ResponseErrorCodeHandler {
  static void handle(
    String code, {
    String? responseMessage,
    String? errorCode,
  }) {
    final context = AppRouter.router.routerDelegate.navigatorKey.currentContext;
    if (context == null) return;

    ModalDialog(
      configs: ModalDialogConfigs(
        title: AppLocalizations.current.information,
        customIconWidget: Assets.svgs.icError.svg(),
        message: "$responseMessage ($errorCode)",
        buttonConfigs: [
          ButtonConfigs(
            state: ButtonState.default$,
            type: ButtonType.primary,
            content: AppLocalizations.current.contactCS,
            onTap: () {
              final Uri telLaunchUri = Uri(
                scheme: 'tel',
                path: '1300887650',
              );
              try {
                launchUrl(telLaunchUri);
              } catch (e) {
                ///
              }
            },
          ),
          ButtonConfigs(
            state: ButtonState.default$,
            type: ButtonType.secondary,
            content: "OK",
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),
    ).show();
  }
}
