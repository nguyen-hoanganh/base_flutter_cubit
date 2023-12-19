import 'dart:async';
import 'dart:developer';

import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_confirmation_dialog/modal_confirmation_dialog.dart';
import 'package:cbp_mobile_app_flutter/common/configs/config_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/notification/notification_manager.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/container/dashboard/cubit/dashboard_cubit.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/repositories/app_repository.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:cbp_mobile_app_flutter/injection.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:cbp_mobile_app_flutter/l10n/localization_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gap/gap.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await beforeRunApp();

  runApp(const MyApp());
}

final globalNavigatorKey = GlobalKey<ScaffoldMessengerState>();

Future<void> beforeRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationManager();
  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );
  await _flavor;
  await setupInjection();
}

Future<void> get _flavor async {
  await const MethodChannel('flavor')
      .invokeMethod<String>('getFlavor')
      .then((String? flavor) => ConfigManager.getInstance(flavorName: flavor))
      .catchError(
    (error) {
      log("Error when set up enviroment: $error");

      return ConfigManager.getInstance(flavorName: FlavorManager.dev.name);
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        AppManager.shared.sessionManager.start();
        DateTime timeResume = DateTime.now();
        Duration difference =
            timeResume.difference(AppManager.shared.sessionTime);
        int secondsDifference = difference.inSeconds;
        if (secondsDifference >= 300 && AppManager.shared.sessionId != '') {
          showPopupLogout();
        }

        break;
      case AppLifecycleState.paused:
        // firstSessionTime = DateTime.now();
        AppManager.shared.sessionTime = DateTime.now();
        AppManager.shared.sessionManager.stop();

        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeDataOverride = ThemeData.light();
    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerBuilder: () => const MaterialClassicHeader(),
      footerBuilder: () => const ClassicFooter(),
      enableLoadingWhenNoData: false,
      enableRefreshVibrate: false,
      enableLoadMoreVibrate: false,
      shouldFooterFollowWhenNotFull: (state) {
        // If you want load more with noMoreData state ,may be you should return false
        return false;
      },
      child: Listener(
        onPointerDown: (_) {
          AppManager.shared.sessionManager.resetRemain();
        },
        onPointerMove: (_) {
          AppManager.shared.sessionManager.resetRemain();
        },
        onPointerUp: (_) {
          AppManager.shared.sessionManager.resetRemain();
        },
        child: ResponsiveSizer(
          builder: (context, orientation, deviceType) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<LocalizationCubit>()),
                BlocProvider(
                  create: (context) =>
                      DashboardCubit(getIt.get<AppRepository>()),
                ),
              ],
              child: Builder(
                builder: (context) {
                  final localizationCubit = context.read<LocalizationCubit>();
                  final locale = context.select(
                    (LocalizationCubit cubit) => cubit.state.locale,
                  );
                  return OverlaySupport.global(
                    key: globalNavigatorKey,
                    child: MaterialApp.router(
                      scaffoldMessengerKey: globalNavigatorKey,
                      title: 'CBP',
                      localizationsDelegates: [
                        RefreshLocalizations.delegate,
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      localeResolutionCallback: (_, __) {
                        localizationCubit.notifyUpdatedLocale();
                        return _;
                      },
                      supportedLocales: AppLocalizations.supportedLocales,
                      routerConfig: AppRouter.router,
                      locale: locale,
                      theme: themeDataOverride,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void showPopupLogout() {
    ModalConfirmationDialog(
      configs: ModalConfirmationDialogConfigs(
        onClose: () => logoutSession(),
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
            logoutSession();
          },
        ),
      ),
    ).show();
  }

  void logoutSession() async {
    AppManager.shared.sessionManager.stop();
    AppManager.shared.sessionId = "";
  }
}
