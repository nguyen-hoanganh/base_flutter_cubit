import 'dart:math';

import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/header_modal/header_modal.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_bottom/keyboard_dismiss.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_bottom/sized_box_safe_area.dart';
import 'package:cbp_mobile_app_flutter/common/screen/base_screen.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

part 'models/modal_bottom_configs.dart';
part 'models/modal_bottom_dragable_configs.dart';
part 'models/modal_bottom_fixed_configs.dart';
part 'models/modal_bottom_flexible_configs.dart';

class ModalBottom extends StatelessWidget {
  ModalBottom({
    Key? key,
    required ModalBottomConfigs configs,
  })  : configs = setDefaultValuesToConfigs(configs),
        super(key: key);

  final ModalBottomConfigs configs;

  static ModalBottomConfigs setDefaultValuesToConfigs(
    ModalBottomConfigs passedConfigs,
  ) {
    return passedConfigs.copyWith(
      dragableConfigs: passedConfigs.dragableConfigs?.copyWith(
        hasSafeAreaTop: passedConfigs.dragableConfigs?.hasSafeAreaTop ??
            passedConfigs.hasSafeAreaTop$,
      ),
      mHeaderModalConfigs:
          (passedConfigs.mHeaderModalConfigs ?? HeaderModalConfigs()).copyWith(
        title: passedConfigs.title,
        isBackground: false,
        colorShape: CommonColors.primaryColor1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget footer = SizedBoxSafeArea(
      width: double.infinity,
      height: 16.s,
      isIncludeBottomSafeArea: true,
    );

    switch (configs.footer$) {
      case ModalBottomFooter.noButton:
        break;
      default:
        footer = Button(configs: ButtonConfigs());
        break;
    }

    return BaseScreen(
      onWillPop: () async => configs.isDismissible$,
      scaffoldBuilder: () => Material(
        color: Colors.transparent,
        child: _BodyWidget(
          configs: configs,
          bodyBuilder: (body) {
            final topWidgets = [
              HeaderModal(
                configs: configs.mHeaderModalConfigs ?? HeaderModalConfigs(),
              ),
              Gap(8.s),
              body,
            ];

            return Container(
              decoration: const BoxDecoration().copyWith(
                color: CommonColors.neutralColor7,
                border: Border.all(
                  width: 1.s,
                  color: CommonColors.neutralColor7,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.s),
                  topRight: Radius.circular(20.s),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top
                  ...(configs.size$ == ModalBottomSize.fixed
                      ? [
                          Expanded(
                            child: Column(
                              children: topWidgets,
                            ),
                          ),
                        ]
                      : topWidgets),

                  // Footer
                  configs.customFooter ?? footer,
                  if (configs.resizeToAvoidBottomInset$)
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<T?> show<T extends Object?>({
    BuildContext? context,
  }) async {
    final currentContext =
        context ?? AppRouter.router.routerDelegate.navigatorKey.currentContext;
    if (currentContext == null) return null;

    T? result;
    configs.onShow?.call();
    switch (configs.size$) {
      case ModalBottomSize.dragable:
        result = await (configs.isDismissible$
            ? showModalBottomSheet(
                context: currentContext,
                isScrollControlled: true,
                barrierColor: configs.isShowOverlayBackground$
                    ? Colors.black.withOpacity(0.8)
                    : Colors.transparent,
                backgroundColor: Colors.transparent,
                builder: (context) => this,
              )
            : showMaterialModalBottomSheet(
                context: currentContext,
                barrierColor: configs.isShowOverlayBackground$
                    ? Colors.black.withOpacity(0.8)
                    : Colors.transparent,
                backgroundColor: Colors.transparent,
                builder: (context) => this,
                isDismissible: false,
                enableDrag: false,
              ));
        break;

      default:
        result = await showMaterialModalBottomSheet(
          context: currentContext,
          barrierColor: configs.isShowOverlayBackground$
              ? Colors.black.withOpacity(0.8)
              : Colors.transparent,
          backgroundColor: Colors.transparent,
          builder: (context) => this,
          isDismissible: configs.isDismissible$,
          enableDrag:
              configs.flexibleConfigs?.enableDrag ?? configs.isDismissible$,
        );
        break;
    }
    configs.onDismiss?.call();

    return result;
  }
}

class _BodyWidget extends StatelessWidget {
  final ModalBottomConfigs configs;
  final Widget Function(Widget body) bodyBuilder;
  const _BodyWidget({
    required this.configs,
    required this.bodyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    switch (configs.size$) {
      case ModalBottomSize.dragable:
        if (configs.dragableConfigs == null) return const SizedBox.shrink();

        return DraggableScrollableSheet(
          maxChildSize: configs.dragableConfigs!.getMaxSize(context),
          initialChildSize: configs.dragableConfigs!.getInitSize(context),
          minChildSize: configs.dragableConfigs!.getMinSize(context),
          snap: true,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return bodyBuilder(
              Flexible(
                child: configs.dragableConfigs!.bodyBuilder
                        ?.call(context, scrollController) ??
                    const SizedBox.shrink(),
              ),
            );
          },
        );
      default:
        double height = MediaQuery.of(context).size.height;
        switch (configs.fixedConfigs?.size$ ?? ModalBottomFixedSize.s) {
          case ModalBottomFixedSize.m:
            height = height * 0.68;
            break;
          case ModalBottomFixedSize.l:
            height = height * 0.85;
            break;
          default:
            height = height * 0.5;
            break;
        }

        // bottom inset ( keyboard, indicator, ... )
        if (configs.resizeToAvoidBottomInset$) {
          height += MediaQuery.of(context).viewInsets.bottom;
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (!configs.hasSafeAreaTop$) return;
            if (!configs.isDismissible$) return;
            GoRouter.of(context).pop();
            // Modular.to.pop();
          },
          child: SafeArea(
            top: configs.hasSafeAreaTop$,
            left: false,
            right: false,
            bottom: false,
            child: KeyboardDismiss(
              child: configs.size$ == ModalBottomSize.flexible
                  ? bodyBuilder(
                      Flexible(
                        child: configs.flexibleConfigs?.body ??
                            const SizedBox.shrink(),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: height,
                      child: bodyBuilder(
                        Flexible(
                          child: configs.fixedConfigs?.body ??
                              const SizedBox.shrink(),
                        ),
                      ),
                    ),
            ),
          ),
        );
    }
  }
}
