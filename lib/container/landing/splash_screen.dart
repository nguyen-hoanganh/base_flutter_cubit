import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_confirmation_dialog/modal_confirmation_dialog.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_dialog/modal_dialog.dart';
import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/inapp_debug_console_manager/draggable_widget/bubble_menu_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/notification/notification_manager.dart';
import 'package:cbp_mobile_app_flutter/common/screen/base_screen.dart';
import 'package:cbp_mobile_app_flutter/common/screen/scaffold/base_scaffold.dart';
import 'package:cbp_mobile_app_flutter/common/screen/scaffold/base_scaffold_configs.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/common/utils/utils.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool jailbroken = false;
  @override
  void initState() {
    super.initState();

    //check Jailbroken
    checkJailbroken().then((value) {
      if (!jailbroken) {
        _getIpAddress();
        _getDeviceInfo();
        _getVersionApp();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          BubbleMenuManager.shared.show(context);
        });
        init();
      }
    });
  }

  Future<bool> checkJailbroken() async {
    jailbroken = await FlutterJailbreakDetection.jailbroken;

    if (jailbroken) {
      ModalDialog(
        configs: ModalDialogConfigs(
          title: AppLocalizations.current.jailbrokenTitle,
          customIconWidget: Assets.svgs.icError.svg(),
          isVisibleCloseButton: true,
          barrierDismissible: false,
          message: AppLocalizations.current.jailbrokenMesage,
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

                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
            ButtonConfigs(
              state: ButtonState.default$,
              type: ButtonType.secondary,
              content: AppLocalizations.current.cancel,
              onTap: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
          ],
        ),
      ).show();
    }

    return jailbroken;
  }

  void init() async {
    NotificationManager.shared.getToken();
    //todo something
  }

  void showPopupMaintenanceMode() {
    ModalConfirmationDialog(
      configs: ModalConfirmationDialogConfigs(
        isVisibleCloseButton: false,
        customIconWidget: Assets.images.icSystem.image(height: 50.s),
        customTitleWidget: Column(
          children: [
            Gap(12.s),
            Text(
              AppLocalizations.current.maintenanceMode,
              style: CommonTextStyle.bodyB2.copyWith(
                color: CommonColors.neutralColor2,
              ),
            ),
            Gap(4.s)
          ],
        ),
        customMessageWidget: Text(
          AppManager.shared.maintenanceMessage,
          style: CommonTextStyle.scriptSubtitle1.copyWith(
            color: CommonColors.secondaryColor2,
          ),
          textAlign: TextAlign.center,
        ),
        buttonPrimaryConfig: ButtonConfigs(
          state: ButtonState.default$,
          type: ButtonType.primary,
          content: AppLocalizations.current.tryAgain,
          contentStyle: CommonTextStyle.bodyB2.copyWith(
            color: CommonColors.neutralColor7,
          ),
          onTap: () {
            init();
          },
        ),
      ),
    ).show();
  }

  void _getIpAddress() async {
    final ipAddress = await Utils.getIpAddress();
    AppManager.shared.ipAddress = ipAddress;
  }

  void _getDeviceInfo() async {
    final deviceInfo = await Utils.getDeviceInformation();
    AppManager.shared.deviceId = deviceInfo['deviceId'];
    AppManager.shared.deviceOS = deviceInfo['deviceOS'];
    AppManager.shared.deviceModel = deviceInfo['deviceModel'];
  }

  void _getVersionApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    AppManager.shared.versionApp = "$version ($buildNumber)";
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      scaffoldBuilder: () => BaseScaffold(
        configs: BaseScaffoldConfigs(
          body: Center(child: Assets.images.logoCBP.image(scale: 3.s)),
        ),
      ),
    );
  }
}
