part of 'notification_manager.dart';

class _NotificationManagerHandler {
  _NotificationManagerHandler._();

  static _NotificationManagerHandler? _instance;

  static _NotificationManagerHandler get instance {
    _instance ??= _NotificationManagerHandler._();

    return _instance!;
  }

  final tag = "NotificationManager";

  void handleOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleOnTapNotification(event);
    });
  }

  void handleNotOpenedApp() {
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      logDebug(
        "$tag handleNotOpenedApp: ${event?.toMap()}",
      );
      InAppDebugConsoleManager.shared.add(
        InAppDebugConsoleModel(
          type: InAppDebugConsoleModelType.info,
          message: '$tag handleNotOpenedApp: ${event?.toMap()}',
        ),
      );
      if (event == null) return;
      if (event.data.containsKey("type")) {
        if (event.data["type"] == "0") {
          NotificationManager.shared.openNotiHandleNotOpenedApp = true;
        }
      }
    });
  }

  void handleOnTapNotification(RemoteMessage? message) {
    if (message == null) return;
    InAppDebugConsoleManager.shared.add(
      InAppDebugConsoleModel(
        type: InAppDebugConsoleModelType.info,
        message: '$tag handleOnTapNotification: ${message.toMap()}',
      ),
    );
    if (message.data.containsKey("type")) {
      if (message.data["type"] == "0") {
        if (!AppManager.shared.isUserLoggedIn) {
          final context =
              AppRouter.router.routerDelegate.navigatorKey.currentContext;
          if (context == null) return;

          // getIt.get<LandingCubit>().secureTacInfo().then((value) {
          //   ModalBottom(
          //     configs: ModalBottomConfigs(
          //       size: ModalBottomSize.fixed,
          //       title: AppLocalizations.current.secureVerification,
          //       footer: ModalBottomFooter.noButton,
          //       fixedConfigs: ModalBottomFixedConfigs(
          //         size: ModalBottomFixedSize.l,
          //         body: BlocProvider(
          //           create: (context) => SecureVerificationCubit(
          //             getIt.get<AppRepository>(),
          //           ),
          //           child: SecureVerificationPage(
          //             agrument: SecureVerificationAgrument(
          //               secureTacInfoResponse: value,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ).show();
          // });

          NotificationManager.shared.addListenEvent("source_verification");
        } else {
          final context =
              AppRouter.router.routerDelegate.navigatorKey.currentContext;
          if (context == null) return;

          ModalDialog(
            configs: ModalDialogConfigs(
              title: AppLocalizations.current.notification,
              customIconWidget: Assets.svgs.icError.svg(),
              message: "Session invalid ",
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
        }
      }
    }
  }
}
