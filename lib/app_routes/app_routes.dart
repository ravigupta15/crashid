import 'dart:async';
import 'dart:developer';
import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:crashid/features/auth/forget_password/presentation/pages/otp_screen.dart';
import 'package:crashid/features/auth/registration/presentation/pages/choose_account_type_screen.dart';
import 'package:crashid/features/auth/registration/presentation/pages/personal_registration_screen.dart';
import 'package:crashid/features/auth/reset_password/presentation/pages/reset_password_screen.dart';
import 'package:crashid/features/auth/signin/presentation/pages/signin_screen.dart';
import 'package:crashid/features/language/presentation/language_screen.dart';
import 'package:crashid/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:crashid/features/splash_screen/presentation/splash_screen.dart';
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
      GoRoute(
        path: AppRoutesPath.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutesPath.languageScreen,
        builder: (context, state) => const LanguageScreen(),
      ),
      
      GoRoute(
        path: AppRoutesPath.onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      GoRoute(
        path: AppRoutesPath.signinScreen,
        builder: (context, state) => const SigninScreen(),
      ),
      
      GoRoute(
        path: AppRoutesPath.forgetPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      
      GoRoute(
        path: AppRoutesPath.otpScreen,
        builder: (context, state) => const OtpScreen(),
      ),
      
      GoRoute(
        path: AppRoutesPath.resetPasswordScreen,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      
      GoRoute(
        path: AppRoutesPath.chooseAccountTypeScreen,
        builder: (context, state) => const ChooseAccountTypeScreen(),
      ),
      GoRoute(
        path: AppRoutesPath.personalRegisterScreen,
        builder: (context, state) => const PersonalRegistrationScreen(),
      ),
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
