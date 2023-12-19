import 'dart:io';

import 'package:cbp_mobile_app_flutter/common/managers/loading_manager.dart';
import 'package:cbp_mobile_app_flutter/l10n/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseScreen extends StatefulWidget {
  final Widget Function() scaffoldBuilder;
  final WillPopCallback? onWillPop;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  const BaseScreen({
    super.key,
    required this.scaffoldBuilder,
    this.onWillPop,
    this.systemUiOverlayStyle,
  });

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with WidgetsBindingObserver {
  late final _cubit = context.read<LocalizationCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _cubit.changeShouldBlurScreen(
      state == AppLifecycleState.inactive || state == AppLifecycleState.paused,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.systemUiOverlayStyle != null) {
      SystemChrome.setSystemUIOverlayStyle(
        widget.systemUiOverlayStyle!.copyWith(
          statusBarColor: Colors.transparent,
        ),
      );
    }

    return BlocBuilder<LocalizationCubit, LocalizationState>(
      buildWhen: (previous, current) =>
          previous.notificationUpdatedLocale !=
              current.notificationUpdatedLocale ||
          previous.shouldBlur != current.shouldBlur,
      builder: (context, state) {


        return state.shouldBlur
            ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade200.withOpacity(1),
            )
            : AppWillPopScope(
                onWillPop: widget.onWillPop,
                child: widget.scaffoldBuilder(),
              );
      },
    );
  }
}

class AppWillPopScope extends WillPopScope {
  AppWillPopScope({
    Key? key,
    required WillPopCallback? onWillPop,
    required Widget child,
  }) : super(
          key: key,
          onWillPop: onWillPop == null && Platform.isIOS
              ? null
              : () async {
                  if (LoadingManager.shared.isShowing) return false;
                  final result = await onWillPop?.call();

                  return result ?? true;
                },
          child: child,
        );
}
