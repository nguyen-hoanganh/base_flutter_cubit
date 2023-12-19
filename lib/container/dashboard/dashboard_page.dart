import 'package:app_settings/app_settings.dart';
import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/base_divider/a_divider_configs.dart';
import 'package:cbp_mobile_app_flutter/common/components/base_divider/a_divider_private.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/gesture_detector/gesture_detector_throttle/gesture_detector_throttle.dart';
import 'package:cbp_mobile_app_flutter/common/components/navigation_bar/navigation_bar_top.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_confirmation_dialog/modal_confirmation_dialog.dart';
import 'package:cbp_mobile_app_flutter/common/components/toggle_button/toggle_button.dart';
import 'package:cbp_mobile_app_flutter/common/extensions/list_ext.dart';
import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/share_pref_manager.dart';
import 'package:cbp_mobile_app_flutter/common/screen/base_screen.dart';
import 'package:cbp_mobile_app_flutter/common/screen/scaffold/base_scaffold.dart';
import 'package:cbp_mobile_app_flutter/common/screen/scaffold/base_scaffold_configs.dart';
import 'package:cbp_mobile_app_flutter/common/theme/box_shadow.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/common/widgets/biometrics.dart';
import 'package:cbp_mobile_app_flutter/container/dashboard/cubit/dashboard_cubit.dart';
import 'package:cbp_mobile_app_flutter/container/dashboard/widget/biometric_verification.dart';
import 'package:cbp_mobile_app_flutter/container/dashboard/widget/contact_us.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

part 'widget/home_function.dart';
part 'widget/menu_drawer.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  // late final _cubit = context.read<DashboardCubit>();

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  Widget get _buildBasicAccount => BlocBuilder<DashboardCubit, DashboardState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  state.user.name ?? "",
                  style: CommonTextStyle.bodyB4.copyWith(height: 1.2),
                ),
              ),
              Gap(8.s),
              Assets.svgs.logoFullColor.svg(
                width: 129.s,
              ),
            ],
          );
        },
      );

  Widget get _buildFunction => Row(
        children: HomeFunctionType.values
            .map(
              (e) => Expanded(
                flex: 1,
                child: HomeFunction(functionType: e),
              ),
            )
            .toList()
            .separator((index) => Gap(8.s)),
      );

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      onWillPop: () async => false,
      scaffoldBuilder: () {
        return BlocListener<DashboardCubit, DashboardState>(
          listener: ((context, state) {
            if (state.isShowMenuDrawer == true) {
              _key.currentState!.openDrawer();
              context.read<DashboardCubit>().handleActiveMenuDrawer(false);
            }
          }),
          child: BaseScaffold(
            configs: BaseScaffoldConfigs(
              key: _key,
              navigationBarTopConfigs: NavigationBarTopConfigs(
                customBackIcon: Assets.svgs.menu.svg(),
                onBackPress: () {
                  _key.currentState!.openDrawer();
                },
                customActions: [
                  GestureDetectorThrottle(
                    configs: GestureDetectorConfigs(
                      child: Assets.svgs.bellNoti.svg(),
                      onTap: () {
                        //todo something
                      },
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: 16.s,
                    horizontal: 24.s,
                  ),
                  child: Column(
                    children: [
                      _buildBasicAccount,
                      _buildFunction,
                    ].separator((index) => Gap(16.s)),
                  ),
                ),
              ),
              drawer: MenuDrawer(
                onPressMenuIcon: () {
                  _key.currentState!.closeDrawer();
                  context.read<DashboardCubit>().handleActiveMenuDrawer(false);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
