import 'package:cbp_mobile_app_flutter/common/components/button/gesture_detector/gesture_detector_throttle/gesture_detector_throttle.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_bottom/modal_bottom.dart';
import 'package:cbp_mobile_app_flutter/common/managers/notification/notification_manager.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/container/landing/cubit/landing_cubit.dart';
import 'package:cbp_mobile_app_flutter/container/secure_verification/cubit/secure_verification_cubit.dart';
import 'package:cbp_mobile_app_flutter/container/secure_verification/secure_verification_agrument.dart';
import 'package:cbp_mobile_app_flutter/container/secure_verification/secure_verification_page.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/repositories/app_repository.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:cbp_mobile_app_flutter/injection.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class NavigateLogin {
  bool? isNavigateLogin;

  NavigateLogin({
    this.isNavigateLogin,
  });
}

class FooterCustomer extends StatelessWidget {
  const FooterCustomer({super.key});

  void onTapSecure(BuildContext context) {
    context.read<LandingCubit>().secureTacInfo().then(
      (value) {
        if (value != null) {
          ModalBottom(
            configs: ModalBottomConfigs(
              size: ModalBottomSize.fixed,
              title: AppLocalizations.current.secureVerification,
              footer: ModalBottomFooter.noButton,
              fixedConfigs: ModalBottomFixedConfigs(
                size: ModalBottomFixedSize.l,
                body: BlocProvider(
                  create: (context) => SecureVerificationCubit(
                    getIt.get<AppRepository>(),
                  ),
                  child: SecureVerificationPage(
                    agrument: SecureVerificationAgrument(
                      secureTacInfoResponse: value,
                    ),
                  ),
                ),
              ),
            ),
          ).show();
        }
      },
    );
  }

  void onTapKillSwitch() {
    //todo something
  }

  @override
  Widget build(BuildContext context) {
    if (NotificationManager.shared.openNotiHandleNotOpenedApp) {
      // Future.delayed(const Duration(seconds: 4), () {
      onTapSecure(context);
      NotificationManager.shared.openNotiHandleNotOpenedApp = false;
      // });
    }

    return BlocBuilder<LandingCubit, LandingState>(
      builder: ((context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _layoutIcon(
              Assets.images.secureTAC.image(
                width: 24.s,
                height: 24.s,
              ),
              AppLocalizations.current.secureVerificationLogin,
              onTap: () => onTapSecure(context),
            ),
            Gap(16.s),
            _layoutIcon(
              Assets.images.killSwitch.image(
                width: 24.s,
                height: 24.s,
              ),
              AppLocalizations.current.killSwitch,
              onTap: onTapKillSwitch,
            ),
          ],
        );
      }),
    );
  }

  Widget _layoutIcon(icon, String text, {Function()? onTap}) {
    return GestureDetectorThrottle(
      configs: GestureDetectorConfigs(
        onTap: () => onTap?.call(),
        child: Column(
          children: [
            icon,
            Gap(5.s),
            Text(
              text,
              textAlign: TextAlign.center,
              style: CommonTextStyle.scriptSubtitle2.copyWith(
                color: CommonColors.primaryColor2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
