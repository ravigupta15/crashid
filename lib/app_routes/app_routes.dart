import 'dart:async';
import 'dart:developer';
import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class AppRouter {
  /// main Navigation Router
  static final GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: mainNavigatorKey,
    redirect: _redirect,
    initialLocation: AppRoutesPath.splashScreen,
    observers: [
    ],
    routes: <RouteBase>[
      // GoRoute(
      //   path: SplashScreen.routeName,
      //   builder: (context, state) => const SplashScreen(),
      // ),
      // GoRoute(
      //   path: OtpVerifyScreen.routeName,
      //   builder: (context, state) {
      //     var argument = state.extra as Map<String, dynamic>?;

      //     return OtpVerifyScreen(
      //       username: argument?[OtpVerifyScreen.kUsername],
      //     );
      //   },
      // ),
          ],
  );

  static FutureOr<String?> _redirect(
    BuildContext context,
    GoRouterState state,
  ) {
    // if (AppConfigUtils.showRoutingLog) {
    log(state.uri.toString(), name: "redirect");
    // }
    return null;
  }
}
