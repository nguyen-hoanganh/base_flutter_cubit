part of '../dashboard_page.dart';

class MenuDrawer extends StatelessWidget {
  final Function()? onPressMenuIcon;

  const MenuDrawer({super.key, this.onPressMenuIcon});

  Widget get _buildLoginInfo => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.s),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<DashboardCubit, DashboardState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                return Text(
                  state.user.name ?? '',
                  style: CommonTextStyle.bodyB3.copyWith(
                    height: 1.2,
                    color: CommonColors.neutralColor2,
                  ),
                );
              },
            ),
            Gap(4.s),
            Text(
              AppManager.shared.lastLogin,
              style: CommonTextStyle.scriptSubtitle1.copyWith(
                height: 1.2,
                color: CommonColors.secondaryColor2,
              ),
            )
          ],
        ),
      );

  Widget _buildNavigationOptions(
    BuildContext context,
    Function()? onPressMenuIcon,
  ) =>
      BlocBuilder<DashboardCubit, DashboardState>(
        buildWhen: (previous, current) =>
            previous.isActiveBiometric != current.isActiveBiometric,
        builder: ((context, state) {
          return Padding(
            padding: EdgeInsets.only(left: 38.s),
            child: Column(
              children: [
                _NavigationOption(
                  icon: Assets.svgs.shieldAndMoney.svg(),
                  title: AppLocalizations.current.killSwitch,
                  onTap: () {
                    //todo something
                  },
                ),
                _NavigationOption(
                  icon: Assets.svgs.smartOtp.svg(),
                  title: AppLocalizations.current.changePassword,
                  onTap: () {
                    //todo something
                  },
                ),
                _NavigationOption(
                  icon: Assets.svgs.qa.svg(),
                  title: AppLocalizations.current.faq,
                  onTap: () {
                    //todo something
                  },
                ),
                _NavigationOption(
                  icon: Assets.svgs.callForHelp.svg(),
                  title: AppLocalizations.current.contactUs,
                  onTap: () {
                    onPressMenuIcon?.call();
                    onShowContactBottomsheet();
                  },
                ),
                _NavigationOption(
                  icon: Assets.svgs.icFace.svg(),
                  title: AppLocalizations.current.biometric,
                  isShowToggle: true,
                  onTap: () {},
                  onSwitch: (value) async {
                    context.read<DashboardCubit>().handleBiometric(value);
                    if (value) {
                      showPopupVerificationBiometric(
                        context,
                        onAgree: (() {
                          _handleCheckBiometric(context);
                        }),
                        onDisAgree: (() async {
                          context.read<DashboardCubit>().handleBiometric(false);
                          context.pushNamed(Routes.biometricResult);
                          await BiometricsAuth.cancelAuthentication();
                        }),
                      );
                    } else {
                      showPopupVerificationBiometric(
                        context,
                        isDisable: true,
                        onAgree: (() {
                          AppManager.shared.pref.putBool(
                            SharedPreferenceKey.activeBiometric,
                            false,
                          );
                        }),
                        onDisAgree: (() {
                          AppRouter.router.pop();
                          context.read<DashboardCubit>().handleBiometric(true);
                        }),
                      );
                    }
                  },
                  isSwitch: state.isActiveBiometric,
                ),
              ].separator((index) => Gap(24.s)),
            ),
          );
        }),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 0.7 * MediaQuery.of(context).size.width,
      child: BaseScaffold(
        configs: BaseScaffoldConfigs(
          navigationBarTopConfigs: NavigationBarTopConfigs(
            customBackIcon:
                Assets.svgs.menu.svg(color: CommonColors.primaryColor2),
            onBackPress: onPressMenuIcon,
            hasRightActions: false,
          ),
          body: Column(
            children: [
              Gap(15.s),
              _buildLoginInfo,
              Gap(27.s),
              _buildNavigationOptions(context, onPressMenuIcon),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  left: 34.s,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SwitchLanguage(),
                    Container(),
                    Gap(16.s),
                  ],
                ),
              ),
              Gap(41.s),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.s),
                child: Column(
                  children: [
                    CustomDivider(
                      configs: const ADividerConfigs(
                        type: ADividerType.line,
                        color: CommonColors.secondaryColor3,
                      ),
                    ),
                    Gap(18.s),
                    BlocBuilder<DashboardCubit, DashboardState>(
                      buildWhen: (previous, current) =>
                          previous.status != current.status,
                      builder: (context, state) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Button(
                            configs: ButtonConfigs(
                              width: 129.s,
                              height: 48.s,
                              padding: EdgeInsets.zero,
                              content: AppLocalizations.current.logOut,
                              contentStyle: CommonTextStyle.bodyB2.copyWith(
                                color: CommonColors.neutralColor7,
                              ),
                              onTap: () {
                                //todo something
                              },
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Gap(33.s),
            ],
          ),
        ),
      ),
    );
  }

  void _handleCheckBiometric(BuildContext context) {
    BiometricsAuth.authenticate()
        .then(
          (value) async => {
            if (value == BiometricStatus.notAvailable)
              {}
            else if (value == BiometricStatus.notEnrolled)
              {}
            else
              {
                context.read<DashboardCubit>().handleBiometric(
                      value == BiometricStatus.success ? true : false,
                    ),
                context.pushNamed(Routes.biometricResult),
                await BiometricsAuth.cancelAuthentication(),
              }
          },
        )
        .catchError((err) {});
  }

  static void _showModalWarningBiometric(
    BuildContext context,
    String title,
    String textButton,
    String? content,
    bool isError,
    Function() onTap,
  ) {
    ModalConfirmationDialog(
      configs: ModalConfirmationDialogConfigs(
        onClose: () => context.read<DashboardCubit>().handleBiometric(false),
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

class _NavigationOption extends StatefulWidget {
  final Widget icon;
  final String title;
  final bool? isShowToggle;
  final Function()? onTap;
  final Function(bool v)? onSwitch;
  final bool? isSwitch;

  const _NavigationOption({
    required this.icon,
    required this.title,
    this.isShowToggle,
    this.onTap,
    this.onSwitch,
    this.isSwitch,
  });

  @override
  State<_NavigationOption> createState() => _NavigationOptionState();
}

class _NavigationOptionState extends State<_NavigationOption> {
  bool isActive = false;

  @override
  void initState() {
    super.initState();

    _checkActiveBiometric();
  }

  Future<void> _checkActiveBiometric() async {
    bool? statusBiometric =
        AppManager.shared.pref.getBool(SharedPreferenceKey.activeBiometric);
    if (statusBiometric != null) {
      setState(() {
        isActive = statusBiometric;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetectorThrottle(
      configs: GestureDetectorConfigs(
        child: Row(
          children: [
            widget.icon,
            Gap(16.s),
            Text(
              widget.title,
              style: CommonTextStyle.scriptSubtitle1.copyWith(
                height: 1.2,
                color: CommonColors.neutralColor2,
              ),
            ),
            if (widget.isShowToggle == true)
              SizedBox(
                width: 16.s,
              ),
            if (widget.isShowToggle == true)
              ToggleButton(
                configs: ToggleConfigs(
                  sizes: 20.s,
                  value: widget.isSwitch ?? isActive,
                  onChange: (value) {
                    widget.onSwitch!(value);
                  },
                ),
              ),
          ],
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
