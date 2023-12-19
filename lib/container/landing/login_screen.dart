import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/input/normal_input/normal_input.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_confirmation_dialog/modal_confirmation_dialog.dart';
import 'package:cbp_mobile_app_flutter/common/extensions/export_packages.dart';
import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/share_pref_manager.dart';
import 'package:cbp_mobile_app_flutter/common/screen/base_screen.dart';
import 'package:cbp_mobile_app_flutter/common/screen/scaffold/base_scaffold.dart';
import 'package:cbp_mobile_app_flutter/common/screen/scaffold/base_scaffold_configs.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/common/utils/utils.dart';
import 'package:cbp_mobile_app_flutter/common/widgets/biometrics.dart';
import 'package:cbp_mobile_app_flutter/container/landing/cubit/landing_cubit.dart';
import 'package:cbp_mobile_app_flutter/container/landing/widget/footer_customer.dart';
import 'package:cbp_mobile_app_flutter/container/landing/widget/footer_login.dart';
import 'package:cbp_mobile_app_flutter/container/landing/widget/header_login.dart';
import 'package:cbp_mobile_app_flutter/container/landing/widget/promotion_login.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sizer/sizer.dart';

part 'widget/body_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isUsername = false;

  List<BiometricType> biometricType = [];
  bool isActiveBiometric = false;
  late final _cubit = context.read<LandingCubit>();

  @override
  void initState() {
    AppManager.shared.sessionManager.stop();
    super.initState();
    _loadUsername();
    _getTypeBiometric();
  }

  void _loadUsername() async {
    String? encryptedDataString =
        AppManager.shared.pref.getString(SharedPreferenceKey.authentication);

    if (encryptedDataString != null && encryptedDataString.isNotEmpty) {
      try {
        final decryptData =
            await Utils.decodeEncryptedDataBase64(encryptedDataString);
        Map<String, dynamic> jsonMap = jsonDecode(decryptData);
        AppManager.shared.username = jsonMap['username'];
        AppManager.shared.password = jsonMap['password'];
        AppManager.shared.userId = jsonMap['userId'];
        setState(() {
          isUsername = true;
        });
      } catch (e) {
        // print("Error decoding DATA LOGIN JSON: $e");
      }
    }
  }

  void _getTypeBiometric() async {
    bool? status =
        AppManager.shared.pref.getBool(SharedPreferenceKey.activeBiometric);
    final type = await BiometricsAuth.getAvailableBiometrics();

    if (status != null) {
      setState(() {
        biometricType = type;
        isActiveBiometric = status;
      });
    }
  }

  void _handleLoginBiometric() async {
    AppManager.shared.sessionTime = DateTime.now();
    if (!isActiveBiometric) {
      _showModalWarningBiometric(
        AppLocalizations.current.titleNotRegisterBiometric,
        AppLocalizations.current.logIn,
        AppLocalizations.current.contentNotRegisterBiometric,
        false,
        (() {
          //todo something
        }),
      );
    } else {
      try {
        final BiometricStatus bio = await BiometricsAuth.authenticate();
        if (!mounted) return;

        if (bio == BiometricStatus.notAvailable) {
          _showModalWarningBiometric(
            AppLocalizations.current.titleNotSupport,
            AppLocalizations.current.ok,
            AppLocalizations.current.contentNotSupport,
            true,
            (() {
              AppRouter.router.pop();
            }),
          );
        } else if (bio == BiometricStatus.notEnrolled) {
          _showModalWarningBiometric(
            AppLocalizations.current.titleNotEnrolled,
            AppLocalizations.current.yes,
            null,
            false,
            (() {
              AppRouter.router.pop();
              AppSettings.openAppSettings(
                type: AppSettingsType.security,
              );
            }),
          );
        } else if (bio == BiometricStatus.success) {
          AppManager.shared.isCheckBiometric = true;
          _cubit.login(AppManager.shared.password, biometric: "1");
        } else {
          //todo something
        }
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      scaffoldBuilder: () => BaseScaffold(
        configs: BaseScaffoldConfigs(
          backgroundColor:
              isUsername ? Colors.transparent : CommonColors.neutralColor7,
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //header
                    const HeaderLanding(),
                    Gap(47.s),
                    // user id
                    BlocBuilder<LandingCubit, LandingState>(
                      builder: (context, state) {
                        return BodyLogin(
                          isUsername: isUsername,
                          biometricType: biometricType,
                          callBack: _handleLoginBiometric,
                        );
                      },
                    ),
                    Gap(50.s),
                    const PromotionLogin(),
                    isUsername ? const FooterCustomer() : const FooterLogin()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // MODAL WARNING WHEN LOGIN BY BIOMETRIC
  static void _showModalWarningBiometric(
    String title,
    String textButton,
    String? content,
    bool isError,
    Function() onTap,
  ) {
    ModalConfirmationDialog(
      configs: ModalConfirmationDialogConfigs(
        customIconWidget:
            isError ? Assets.svgs.icError.svg() : Assets.svgs.icInfo.svg(),
        customTitleWidget: Column(
          children: [
            Gap(12.s),
            Text(
              title,
              style: CommonTextStyle.bodyB2,
              textAlign: TextAlign.center,
            ),
            Gap(4.s)
          ],
        ),
        customMessageWidget: content != null
            ? Text(
                content,
                style: CommonTextStyle.scriptSubtitle1
                    .copyWith(color: CommonColors.secondaryColor1),
                textAlign: TextAlign.center,
              )
            : Container(),
        buttonPrimaryConfig: ButtonConfigs(
          state: ButtonState.default$,
          type: ButtonType.primary,
          contentStyle: CommonTextStyle.bodyB2
              .copyWith(color: CommonColors.neutralColor7),
          content: textButton,
          onTap: onTap,
        ),
      ),
    ).show();
  }
}
