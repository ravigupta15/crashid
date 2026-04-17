import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/onboarding/helper/onboarding_helper.dart';
import 'package:crashid/features/onboarding/presentation/widgets/indicator_widget.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  static void open(BuildContext context) {
    context.push(AppRoutesPath.onboardingScreen);
  }

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;

  int selectedIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _screenContent());
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 30),
        child: Column(
          children: [
            Image.asset(AppAssetPaths.appLogoIcon, height: 40),
            const SizedBox(height: 40), 
            Expanded(
              child: PageView.builder(
                itemCount: OnboardingHelper.list.length,
                controller: _pageController,
                physics: ScrollPhysics(),
                onPageChanged: (value) => setState(() => selectedIndex = value),
                itemBuilder: (ctx, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(OnboardingHelper.list[index]['img']),
                      SizedBox(height: 48),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          OnboardingHelper.list[index]['title'],
                          style: context.titleMedium.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        OnboardingHelper.list[index]['subTitle'],
                        textAlign: TextAlign.center,
                        style: context.labelMedium.copyWith(
                          height: 1.8,
                          letterSpacing: .3,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColors.darkGrayColor.withValues(alpha: .6),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(OnboardingHelper.list.length, (index) {
                return selectedIndex == index
                    ? indicatorWidget(false)
                    : indicatorWidget(true);
              }),
            ),
            const SizedBox(height: 40),
            AppElevatedButton.withTitle(
              title: AppLocalizations.of(context)!.getStarted, onPressed: _openSigninScreen),
          ],
        ),
      ),
    );
  }

  
  // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

void _openSigninScreen() {
    context.push(AppRoutesPath.signinScreen);
  }

}
