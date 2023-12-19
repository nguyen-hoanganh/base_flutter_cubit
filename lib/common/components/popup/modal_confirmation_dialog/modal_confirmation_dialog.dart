import 'package:flutter/material.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_dialog/modal_dialog.dart';
part 'models/modal_confirmation_dialog_configs.dart';

class ModalConfirmationDialog {
  final ModalConfirmationDialogConfigs configs;

  const ModalConfirmationDialog({
    required this.configs,
  });

  Future<T?> show<T extends Object?>({
    BuildContext? context,
  }) async {
    return _ModalConfirmationDialogPrivate(
      configs: _ModalConfirmationDialogPrivate.setDefaultValuesToConfigs(
        configs,
      ),
    ).show(context: context);
  }
}

class _ModalConfirmationDialogPrivate extends ModalDialog {
  _ModalConfirmationDialogPrivate({
    required ModalConfirmationDialogConfigs configs,
  }) : super(
          configs: ModalDialogConfigs(
            title: configs.isShowTitle$ ? configs.title : null,
            customTitleWidget: configs.customTitleWidget,
            message: configs.message,
            customMessageWidget: configs.customMessageWidget,
            isVisibleIcon: configs.isVisibleIcon,
            customIconWidget: configs.customIconWidget,
            iconSize: configs.iconSize,
            isVisibleCloseButton: configs.isVisibleCloseButton$,
            barrierDismissible: configs.barrierDismissible$,
            buttonConfigs: configs.buttonPrimaryConfig != null ||
                    configs.buttonSecondaryConfig != null
                ? [
                    ...(configs.buttonPrimaryConfig != null
                        ? [configs.buttonPrimaryConfig!]
                        : []),
                    ...(configs.buttonSecondaryConfig != null
                        ? [configs.buttonSecondaryConfig!]
                        : [])
                  ]
                : null,
            onClose: configs.onClose,
            onShow: configs.onShow,
            onDismiss: configs.onDismiss,
          ),
        );

  static ModalConfirmationDialogConfigs setDefaultValuesToConfigs(
    ModalConfirmationDialogConfigs passedConfigs,
  ) {
    return passedConfigs.copyWith(
      buttonPrimaryConfig:
          passedConfigs.buttonPrimaryConfig?.copyWith(type: ButtonType.primary),
      buttonSecondaryConfig: passedConfigs.buttonSecondaryConfig
          ?.copyWith(type: ButtonType.secondary),
    );
  }
}
