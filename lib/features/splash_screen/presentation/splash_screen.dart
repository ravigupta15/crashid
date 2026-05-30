import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/data_sources/local_storage/secure_storage.dart';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:crashid/di/service_locator.dart';
import 'package:crashid/features/app_navigation/presentation/pages/app_navigation_screen.dart';
import 'package:crashid/features/auth/signin/presentation/pages/signin_screen.dart';
import 'package:crashid/features/language/presentation/language_screen.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToNextScreen();
    super.initState();
  }

  void _navigateToNextScreen() async {
    final getValue = GetIt.I<UserManager>();
    final token = await GetIt.I<SecureStorage>().getUserToken();
    Future.delayed(const Duration(seconds: 3), () {
      if (!getValue.isFirstTime) {
        _openLanguageScreen();
      } else if ((token ?? '').toString().isNotEmpty) {
        _openAppNavigationScreen();
      } else {
        _openSignInScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _screenContent());
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssetPaths.splashIcon, height: 102, width: 260),
          Text(
            "Aufzeichnung, Sicherung. Weiterfahren",
            style: context.titleMedium.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

  void _openLanguageScreen() {
    // LanguageScreen.open(context);
    context.go(AppRoutesPath.languageScreen);
  }

  void _openAppNavigationScreen() {
    // AppNavigationScreen.open(context);
    context.go(AppRoutesPath.appNavigationScreen);
  }

  void _openSignInScreen() {
    // SigninScreen.open(context);
    context.go(AppRoutesPath.signinScreen);
  }
}
