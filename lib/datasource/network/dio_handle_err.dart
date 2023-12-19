import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_dialog/modal_dialog.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/dio_error.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class DioErrorHandler {
  static void handle(
    DioCustomErrorType errorType, {
    DioError? dioError,
    bool? isDismissible,
    Function()? onRetry,
  }) async {
    final context = AppRouter.router.routerDelegate.navigatorKey.currentContext;
    if (context == null) return;

    switch (errorType) {
      case DioCustomErrorType.cancel:
        break;
      case DioCustomErrorType.disconnected:
        ModalDialog(
          configs: ModalDialogConfigs(
            title: AppLocalizations.current.oop,
            customIconWidget: Assets.svgs.icError.svg(),
            message: AppLocalizations.current.checkInternet,
            buttonConfigs: [
              ButtonConfigs(
                state: ButtonState.default$,
                type: ButtonType.primary,
                content: "OK",
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          ),
        ).show();
        break;
      // case DioCustomErrorType.other:
      //   ModalConfirmationDialog(
      //     configs: ModalConfirmationDialogConfigs(
      //       title: 'Title',
      //       message:
      //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed doLorem ipsum dolor sit amet, consectetur adipiscing elit, sed doLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do',
      //       buttonPrimaryConfig: ButtonConfigs(
      //         state: ButtonState.default$,
      //         type: ButtonType.primary,
      //         content: "OK",
      //         onTap: () {
      //           Navigator.of(context, rootNavigator: true).pop();
      //         },
      //       ),
      //     ),
      //   ).show();

      //   break;

      default:
        ModalDialog(
          configs: ModalDialogConfigs(
            title: AppLocalizations.current.oop,
            customIconWidget: Assets.svgs.icError.svg(),
            message: AppLocalizations.current.errTryLater,
            buttonConfigs: [
              ButtonConfigs(
                state: ButtonState.default$,
                type: ButtonType.primary,
                content: "OK",
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          ),
        ).show();

        break;
    }
  }
}
