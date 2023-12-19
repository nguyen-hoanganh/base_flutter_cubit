import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/base_result/base_result.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/container/dashboard/cubit/dashboard_cubit.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricResult extends StatelessWidget {
  const BiometricResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: ((context, state) {
        String title = state.isActiveBiometric == true
            ? AppLocalizations.current.confirmBiometricSuccess
            : AppLocalizations.current.confirmBiometricFail;
        String textButton = state.isActiveBiometric == true
            ? AppLocalizations.current.goToSetting
            : AppLocalizations.current.tryAgain;
        Widget contentLayoutWidget = Container();
        if (state.isActiveBiometric != true) {
          contentLayoutWidget = RichText(
            textAlign: TextAlign.center,
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
                  text: '\n${AppLocalizations.current.contentBlock3}',
                  style: CommonTextStyle.scriptSubtitle1
                      .copyWith(color: CommonColors.secondaryColor2),
                ),
              ],
            ),
          );
        }
        return BaseResult(
          configs: BaseResultConfigs(
            title: title,
            isSuccess: state.isActiveBiometric == true,
            textButton: textButton,
            contentLayoutWidget: contentLayoutWidget,
            handleButton: () {
              AppRouter.popUntilRoute(
                context,
                path: Routes.homeNamedPage,
              );
              context.read<DashboardCubit>().handleActiveMenuDrawer(true);
            },
          ),
        );
      }),
    );
  }
}
