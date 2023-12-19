import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/gesture_detector/gesture_detector_opacity/gesture_detector_opacity.dart';
import 'package:cbp_mobile_app_flutter/common/theme/box_shadow.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

part 'models/navigation_bar_top_configs.dart';

class NavigationBarTop extends StatelessWidget implements PreferredSizeWidget {
  final NavigationBarTopConfigs configs;

  NavigationBarTop({
    Key? key,
    required NavigationBarTopConfigs configs,
  })  : configs = setDefaultValuesToConfigs(configs),
        super(key: key);

  static NavigationBarTopConfigs setDefaultValuesToConfigs(
    NavigationBarTopConfigs passedConfigs,
  ) {
    return passedConfigs = passedConfigs.copyWith(
      boxShadow: [
        CommonBoxShadow.shadowLight1,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasBackIcon = configs.hasBackIcon ?? true;
    final hasRightActions = configs.hasRightActions ?? true;
    Widget titleLeadingWidget = const SizedBox.shrink();

    if (configs.titleLeadingSpacing != null) {
      titleLeadingWidget = SizedBox(width: configs.titleLeadingSpacing);
    } else if (hasBackIcon) {
      titleLeadingWidget = SizedBox(width: 12.s);
    }

    final child = SafeArea(
      child: Container(
        height: getHeightWithoutStatusBar(configs: configs),
        padding: EdgeInsets.symmetric(horizontal: 24.s),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (hasBackIcon)
              GestureDetectorOpacity(
                configs: GestureDetectorConfigs(
                  onTap:
                      configs.onBackPress ?? () => Navigator.of(context).pop(),
                  child: configs.customBackIcon ??
                      Assets.svgs.arrowLeft.svg(
                        height: 24.s,
                        width: 24.s,
                        color: CommonColors.secondaryColor1,
                      ),
                ),
              ),
            titleLeadingWidget,
            Expanded(
              child: configs.customTitle ??
                  Text(
                    configs.pageTitle ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CommonTextStyle.bodyB3.copyWith(
                      color: hasRightActions
                          ? CommonColors.primaryColor1
                          : CommonColors.neutralColor1,
                      height: 0,
                    ),
                  ),
            ),
            if (hasRightActions)
              ...configs.customActions ?? _buildDefaultActions(context)
          ],
        ),
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: configs.borderRadius ?? BorderRadius.zero,
        boxShadow: configs.boxShadow,
        color: configs.backgroundColor ?? CommonColors.neutralColor7,
      ),
      child: ClipRRect(
        borderRadius: configs.borderRadius ?? BorderRadius.zero,
        child: child,
      ),
    );
  }

  List<Widget> _buildDefaultActions(BuildContext context) {
    return [
      SizedBox(width: 12.s),
      GestureDetectorOpacity(
        configs: GestureDetectorConfigs(
          onTap: () {
            AppRouter.popUntilRoute(
              context,
              path: Routes.homeNamedPage,
            );
          },
          child: Assets.svgs.homeLine.svg(
            height: 24.s,
            width: 24.s,
            color: CommonColors.neutralColor1,
          ),
        ),
      ),
    ];
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(getHeightWithoutStatusBar(configs: configs));

  static double? _statusBarHeight;
  static double get _defaultHeight => 52.s;

  static double getHeightWithoutStatusBar({NavigationBarTopConfigs? configs}) {
    return configs?.height ?? _defaultHeight;
  }

  static double getFullHeight({NavigationBarTopConfigs? configs}) {
    return (_statusBarHeight ?? 0) +
        getHeightWithoutStatusBar(configs: configs);
  }

  static void setStatusBarHeight(double height) {
    if (_statusBarHeight != null) return;

    _statusBarHeight = height;
  }
}
