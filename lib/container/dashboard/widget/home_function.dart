part of '../dashboard_page.dart';

enum HomeFunctionType {
  accountSummary,
  fundTransfer,
  // secureVerification,
}

extension HomeFunctionTypeX on HomeFunctionType {
  String get title {
    switch (this) {
      case HomeFunctionType.accountSummary:
        return AppLocalizations.current.accountSummary;
      case HomeFunctionType.fundTransfer:
        return AppLocalizations.current.fundTransfer;
      // case HomeFunctionType.secureVerification:
      //   return AppLocalizations.current.secureVerification;
    }
  }

  Widget get icon {
    switch (this) {
      case HomeFunctionType.accountSummary:
        return Assets.svgs.loan.svg();
      case HomeFunctionType.fundTransfer:
        return Assets.svgs.moneyLine.svg();
      // case HomeFunctionType.secureVerification:
      //   return Assets.svgs.shieldPlusLine.svg();
    }
  }

  String get path {
    switch (this) {
      case HomeFunctionType.accountSummary:
        return Routes.homeNamedPage.toString();
      case HomeFunctionType.fundTransfer:
        return Routes.homeNamedPage.toString();
      // case HomeFunctionType.secureVerification:
      //   return "";
    }
  }
}

class HomeFunction extends StatefulWidget {
  final HomeFunctionType functionType;
  const HomeFunction({
    required this.functionType,
    super.key,
  });

  @override
  State<HomeFunction> createState() => _HomeFunctionState();
}

class _HomeFunctionState extends State<HomeFunction> {
  late final _cubit = context.read<DashboardCubit>();

  @override
  Widget build(BuildContext context) {
    return GestureDetectorThrottle(
      configs: GestureDetectorConfigs(
        onTap: () async {
          if (widget.functionType == HomeFunctionType.accountSummary) {
            GoRouter.of(context).push(Routes.homeNamedPage.toString());
          } else {
            if (AppManager.shared.coolingOff == "1") {
              // ignore: use_build_context_synchronously
              GoRouter.of(context).push(Routes.homeNamedPage.toString());
            } else {
              showPopupCoolingOff();
            }
          }
        },
        child: Container(
          height: 80.s,
          padding: EdgeInsets.all(8.s),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: CommonColors.primaryColor1,
            boxShadow: [
              CommonBoxShadow.shadowLight2,
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.functionType.icon,
              Gap(8.s),
              Text(
                widget.functionType.title,
                style: CommonTextStyle.scriptSubtitle1.copyWith(
                  color: CommonColors.neutralColor7,
                  height: 1.2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showPopupCoolingOff() {
    ModalConfirmationDialog(
      configs: ModalConfirmationDialogConfigs(
        isVisibleCloseButton: false,
        customIconWidget: Assets.svgs.icInformation.svg(),
        customTitleWidget: Column(
          children: [
            Gap(12.s),
            Text(
              "",
              style: CommonTextStyle.bodyB2.copyWith(
                color: CommonColors.neutralColor2,
              ),
            ),
            Gap(4.s)
          ],
        ),
        customMessageWidget: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "",
            style: CommonTextStyle.scriptSubtitle1
                .copyWith(color: CommonColors.secondaryColor2),
            children: [
              TextSpan(
                text: "",
                style: CommonTextStyle.scriptSubtitle1
                    .copyWith(color: CommonColors.accentColor2),
              ),
              TextSpan(
                text: 'for assistance',
                style: CommonTextStyle.scriptSubtitle1
                    .copyWith(color: CommonColors.secondaryColor2),
              ),
            ],
          ),
        ),
        buttonPrimaryConfig: ButtonConfigs(
          state: ButtonState.default$,
          type: ButtonType.primary,
          content: AppLocalizations.current.contactCS,
          contentStyle: CommonTextStyle.bodyB2.copyWith(
            color: CommonColors.neutralColor7,
          ),
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
        buttonSecondaryConfig: ButtonConfigs(
          state: ButtonState.default$,
          type: ButtonType.primary,
          content: 'OK'.toUpperCase(),
          onTap: () {
            Navigator.of(AppRouter.rootNavigatorKey.currentContext!).pop();
          },
        ),
      ),
    ).show();
  }
}
