import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/gesture_detector/gesture_detector_opacity/gesture_detector_opacity.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/gesture_detector/gesture_detector_throttle/gesture_detector_throttle.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_dialog/widgets/surface_overlay.dart';
import 'package:cbp_mobile_app_flutter/common/extensions/object_ext.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

part 'models/modal_dialog_configs.dart';

class ModalDialog extends StatelessWidget {
  const ModalDialog({
    Key? key,
    required this.configs,
  }) : super(key: key);

  final ModalDialogConfigs configs;

  @override
  Widget build(BuildContext context) {
    return _ModalDialogPrivate(configs: configs);
  }

  Future<T?> show<T extends Object?>({
    BuildContext? context,
  }) async {
    final currentContext =
        context ?? AppRouter.router.routerDelegate.navigatorKey.currentContext;
    if (currentContext == null) return null;

    configs.onShow?.call();
    final result = await showGeneralDialog(
      context: currentContext,
      barrierColor: Colors.transparent,
      pageBuilder: (_, __, ___) => this,
    );
    configs.onDismiss?.call();

    return safeCast<T>(result);
  }
}

class _ModalDialogPrivate extends StatelessWidget {
  _ModalDialogPrivate({
    required ModalDialogConfigs configs,
  }) : configs = setDefaultValuesToConfigs(configs);

  final ModalDialogConfigs configs;

  static ModalDialogConfigs setDefaultValuesToConfigs(
    ModalDialogConfigs passedConfigs,
  ) {
    return passedConfigs.copyWith(
      iconSize: passedConfigs.iconSize ?? 42.s,
      margin: passedConfigs.margin ??
          (passedConfigs.isFullScreen == true ? null : EdgeInsets.all(16.s)),
      padding: passedConfigs.padding ?? EdgeInsets.all(24.s),
      isVisibleCloseButton: passedConfigs.isVisibleCloseButton ?? true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFullScreen = configs.isFullScreen ?? false;
    final isSafeArea = configs.isSafeArea ?? true;

    final barrierDismissible = configs.barrierDismissible ?? true;

    return WillPopScope(
      onWillPop: () async => barrierDismissible,
      child: Material(
        color: Colors.transparent,
        child: GestureDetectorThrottle(
          configs: GestureDetectorConfigs(
            onTap: () => {},
            child: SurfaceOverlay(
              configs: SurfaceOverlayConfigs(
                customConfigs: SurfaceConfigs(
                  width: double.infinity,
                  height: double.infinity,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () => {},
                    child: Container(
                      width: double.infinity,
                      height: isFullScreen ? double.infinity : null,
                      margin: configs.margin,
                      padding: configs.padding,
                      decoration: BoxDecoration(
                        borderRadius:
                            isFullScreen ? null : BorderRadius.circular(4.s),
                        color: CommonColors.neutralColor7,
                        border: Border.all(
                          color: CommonColors.neutralColor7,
                        ),
                      ),
                      child: SafeArea(
                        top: isSafeArea && isFullScreen,
                        bottom: isSafeArea && isFullScreen,
                        left: isSafeArea && isFullScreen,
                        right: isSafeArea && isFullScreen,
                        child: configs.customLayoutWidget ??
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (barrierDismissible)
                                  _buildCloseButtonWidget(context),
                                Flexible(child: _buildContentWidget()),
                                _buildActionsWidget(),
                              ],
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButtonWidget(BuildContext context) {
    return Visibility(
      visible: configs.isVisibleCloseButton ?? true,
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetectorOpacity(
          configs: GestureDetectorConfigs(
            onTap: () {
              configs.onClose?.call();
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 12.s),
              child: SizedBox(
                width: 24.s,
                height: 24.s,
                child: Center(
                  child: Icon(
                    Icons.close,
                    size: 24.s,
                    color: CommonColors.primaryColor1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconWidget(),
        _buildTitleWidget(),
        _buildMessageWidget(),
      ],
    );
  }

  Widget _buildIconWidget() {
    return Visibility(
      visible: configs.isVisibleIcon ?? true,
      child: configs.customIconWidget != null
          ? SizedBox(
              width: configs.iconSize,
              height: configs.iconSize,
              child: configs.customIconWidget,
            )
          : SizedBox(
              width: configs.iconSize,
              height: configs.iconSize,
              child: Icon(
                Icons.info,
                size: 32.s,
                color: CommonColors.primaryColor2,
              ),
            ),
    );
  }

  Widget _buildTitleWidget() {
    final title = configs.title ?? "";

    return configs.customTitleWidget ??
        Visibility(
          visible: title.isNotEmpty,
          child: Padding(
            padding: EdgeInsets.only(top: 12.s),
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: CommonTextStyle.headingH6.copyWith(
                color: CommonColors.neutralColor2,
              ),
            ),
          ),
        );
  }

  Widget _buildMessageWidget() {
    final title = configs.title ?? "";
    final message = configs.message ?? "";

    return configs.customMessageWidget ??
        Visibility(
          visible: message.isNotEmpty,
          child: Padding(
            padding: EdgeInsets.only(
              top: title.isEmpty ? 16.s : 6.s,
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 12,
              overflow: TextOverflow.ellipsis,
              style: CommonTextStyle.scriptSubtitle1.copyWith(
                color: CommonColors.secondaryColor2,
              ),
            ),
          ),
        );
  }

  Widget _buildActionsWidget() {
    return Visibility(
      visible: configs.actions$.isNotEmpty,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(12.s),
          ..._getActionsWithSpace(),
        ],
      ),
    );
  }

  List<Widget> _getActionsWithSpace() {
    List<Widget> result = [];
    for (var i = 0; i < configs.actions$.length; i++) {
      if (i == 0) {
        result.add(Button(configs: configs.actions$[i]));
        continue;
      }

      result.add(Gap(12.s));
      result.add(Button(configs: configs.actions$[i]));
    }

    return result;
  }
}
