import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/language/presentation/language_screen.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

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

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      _openLanguageScreen();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenContent(),
    );
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
        Image.asset(AppAssetPaths.splashIcon, height: 102,width: 260,),
        Text("Aufzeichnung, Sicherung. Weiterfahren",
         style: context.titleMedium.copyWith(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 8
         ))
      ],
    ),
  );
 }

 // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

void _openLanguageScreen() {
  LanguageScreen.open(context); 
}
}