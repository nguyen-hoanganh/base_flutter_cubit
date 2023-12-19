import 'package:cbp_mobile_app_flutter/common/widgets/not_found_page.dart';
import 'package:cbp_mobile_app_flutter/container/dashboard/biometric_result.dart';
import 'package:cbp_mobile_app_flutter/container/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const root = '/';
  static const homeNamedPage = '/home';
  static const biometricResult = '/biometricResult';

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundScreen();
}

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  // static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: Routes.homeNamedPage,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: Routes.homeNamedPage,
        name: Routes.homeNamedPage,
        builder: (context, state) => const DashBoardPage(),
      ),
      GoRoute(
        path: Routes.biometricResult,
        name: Routes.biometricResult,
        builder: (context, state) => const BiometricResult(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;

  static void pushNameAndRemoveUntil(
    BuildContext context, {
    required String name,
    String? popUntilPage,
    Object? extra,
  }) {
    Navigator.popUntil(context, ModalRoute.withName(popUntilPage ?? name));
    GoRouter.of(context).pushReplacementNamed(
      name,
      extra: extra,
    );
  }

  static void popUntilRoute(
    BuildContext context, {
    required String path,
  }) {
    Navigator.of(context).popUntil(ModalRoute.withName(path));
  }

  static void clearAndNavigate(String path, {Object? data}) {
    while (AppRouter.router.canPop() == true) {
      AppRouter.router.pop();
    }
    AppRouter.router.pushReplacement(path, extra: data);
  }
}
