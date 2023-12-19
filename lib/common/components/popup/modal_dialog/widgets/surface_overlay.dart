import 'package:cbp_mobile_app_flutter/common/components/popup/modal_dialog/modal_dialog.dart';
import 'package:flutter/material.dart';

class SurfaceOverlay extends StatelessWidget {
  final SurfaceOverlayConfigs configs;

  const SurfaceOverlay({
    Key? key,
    required this.configs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SurfaceOverlayPrivate(configs: configs);
  }
}

class _SurfaceOverlayPrivate extends StatelessWidget {
  final SurfaceOverlayConfigs configs;

  _SurfaceOverlayPrivate({
    Key? key,
    required SurfaceOverlayConfigs configs,
  })  : configs = setDefaultValuesToConfigs(configs),
        super(key: key);

  static SurfaceOverlayConfigs setDefaultValuesToConfigs(
    SurfaceOverlayConfigs passedConfigs,
  ) {
    return passedConfigs.copyWith(
      customConfigs: (passedConfigs.customConfigs ?? SurfaceConfigs()).copyWith(
        decoration:
            (passedConfigs.customConfigs?.decoration ?? const BoxDecoration())
                .copyWith(
          color: passedConfigs.customConfigs?.color ??
              passedConfigs.customConfigs?.decoration?.color ??
              Colors.black.withOpacity(0.8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: configs.customConfigs?.width,
      height: configs.customConfigs?.height,
      alignment: configs.customConfigs?.alignment,
      padding: configs.customConfigs?.padding,
      decoration: configs.customConfigs?.decoration,
      constraints: configs.customConfigs?.constraints,
      margin: configs.customConfigs?.margin,
      child: configs.child,
    );
  }
}
