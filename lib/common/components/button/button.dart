import 'package:cbp_mobile_app_flutter/common/components/button/gesture_detector/gesture_detector_opacity/gesture_detector_opacity.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

part 'models/button_configs.dart';

class Button extends StatelessWidget {
  final ButtonConfigs configs;

  Button({
    Key? key,
    required ButtonConfigs configs,
  })  : configs = setDefaultValuesToConfigs(configs),
        super(key: key);

  static ButtonConfigs setDefaultValuesToConfigs(
    ButtonConfigs passedConfigs,
  ) {
    TextStyle? contentStyle;
    EdgeInsetsGeometry? padding = EdgeInsets.all(12.s);

    Color? backgroundColor;
    Border? border;
    Widget Function(ButtonConfigs currentConfig)? customLoadingWidget;
    switch (passedConfigs.type$) {
      case ButtonType.secondary:
        contentStyle = CommonTextStyle.bodyB2.copyWith(
          color: passedConfigs.disabled$ ||
                  passedConfigs.state == ButtonState.loading
              ? CommonColors.neutralColor5
              : CommonColors.primaryColor1,
        );
        border = Border.all(
          color: passedConfigs.disabled$ ||
                  passedConfigs.state == ButtonState.loading
              ? CommonColors.neutralColor5
              : CommonColors.primaryColor1,
        );
        backgroundColor = passedConfigs.disabled$ ||
                passedConfigs.state == ButtonState.loading
            ? CommonColors.neutralColor6
            : Colors.transparent;
        break;

      default:
        backgroundColor = passedConfigs.disabled$ ||
                passedConfigs.state == ButtonState.loading
            ? CommonColors.secondaryColor6
            : CommonColors.primaryColor1;
        contentStyle = CommonTextStyle.bodyB2.copyWith(
          color: CommonColors.neutralColor7,
        );
        break;
    }

    return passedConfigs.copyWith(
      contentStyle: passedConfigs.contentStyle ?? contentStyle,
      backgroundColor: passedConfigs.backgroundColor ?? backgroundColor,
      padding: passedConfigs.padding ?? padding,
      borderRadius: passedConfigs.borderRadius ?? BorderRadius.circular(4.s),
      border: passedConfigs.border ?? border,
      customLoadingWidget:
          passedConfigs.customLoadingWidget ?? customLoadingWidget,
      gradient: passedConfigs.gradient,
      contentColor: passedConfigs.contentColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isForceLoading = false;

    return StatefulBuilder(
      builder: (context, setState) {
        bool disabled = configs.state$ == ButtonState.loading ||
            configs.disabled$ ||
            isForceLoading;
        bool isOpacityWhenDisabled =
            !(configs.state$ == ButtonState.loading || isForceLoading);

        final child = Container(
          width: configs.width,
          height: configs.height,
          padding: configs.padding,
          decoration: BoxDecoration(
            color: configs.backgroundColor,
            border: configs.border,
            borderRadius: configs.borderRadius,
            gradient: configs.gradient,
          ),
          child: _buildChildWidget(isForceLoading),
        );

        return GestureDetectorOpacity(
          configs: GestureDetectorConfigs(
            onTap: () async {
              if (configs.onTapWithLoading != null) {
                setState(() => isForceLoading = true);
                await configs.onTapWithLoading?.call();
                setState(() => isForceLoading = false);
              } else {
                configs.onTap?.call();
              }
            },
            disabled: disabled,
            isOpacityWhenDisabled: isOpacityWhenDisabled,
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildChildWidget(bool isForceLoading) {
    return Stack(
      children: [
        Center(
          child: Opacity(
            opacity:
                configs.state$ == ButtonState.loading || isForceLoading ? 0 : 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: configs.customContentWidget ??
                      Text(
                        configs.isContentAllCaps$
                            ? (configs.content?.toUpperCase() ?? "")
                            : configs.content ?? "",
                        textAlign: TextAlign.center,
                        overflow: configs.contentOverflow,
                        maxLines: (configs.contentMaxLines ?? 0) <= 0
                            ? null
                            : configs.contentMaxLines,
                        style: configs.contentStyle?.copyWith(
                          color: configs.contentColor ??
                              configs.contentStyle?.color,
                          decoration: configs.isContentUnderline$
                              ? TextDecoration.underline
                              : null,
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
        if (configs.state$ == ButtonState.loading || isForceLoading)
          Positioned.fill(
            child: configs.customLoadingWidget?.call(configs) ??
                Text(
                  '---',
                  textAlign: TextAlign.center,
                  style: configs.contentStyle,
                ),
          )
      ],
    );
  }
}
