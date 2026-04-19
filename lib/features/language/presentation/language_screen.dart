import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/lookup/language_provider.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_radio_button/app_radio_button.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/empty/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  static const kRoute = "/kRoute";
  
  final bool? isChangeLanguageRoute;
  static void open(BuildContext context, {
    bool? isChangeLanguageRoute
  }) {
    context.push(AppRoutesPath.languageScreen, extra: {
      kRoute: isChangeLanguageRoute
    });
  }

  const LanguageScreen({super.key, this.isChangeLanguageRoute});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  int _selectedLanguageIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final current = Provider.of<LanguageProvider>(context, listen: false).locale;
      setState(() {
        _selectedLanguageIndex = current.languageCode == 'de' ? 0 : 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.isChangeLanguageRoute ?? false) ? CustomAppBar(
        title: 
              AppLocalizations.of( context)!.changeLanguage ,
      ) : null,
      body: _screenContent());
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (widget.isChangeLanguageRoute ?? false) ? EmptyWidget() :
            Center(
              child: Image.asset(AppAssetPaths.appLogoIcon, height: 40,),
            ),
            const Spacer(),
            Text(
             (widget.isChangeLanguageRoute ?? false) ? 
              AppLocalizations.of( context)!.changeLanguage :
              AppLocalizations.of( context)!.selectLangauge,
              style: context.headlineMedium.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 24,
                color: AppColors.blackColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 17),
            Text(
              AppLocalizations.of( context)!.chooseLanguage,
              style: context.bodyMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _languageOption(
              index: 0,
              title: AppLocalizations.of( context)!.german,
              iconPath: AppAssetPaths.germanIcon,
            ),
            const SizedBox(height: 18),
            _languageOption(
              index: 1,
              title: AppLocalizations.of( context)!.english,
              iconPath: AppAssetPaths.englishIcon,
            ),
            const Spacer(),
            AppElevatedButton.withTitle(title: AppLocalizations.of( context)!.continueTitle, 
            onPressed: (widget.isChangeLanguageRoute ?? false) ? _onPop : _openOnboardingScreen)
              ],
        ),
      ),
    );
  }

  Widget _languageOption({
    required int index,
    required String title,
    required String iconPath,
  }) {

    return GestureDetector(
      onTap: () => _onLanguageChanged(index),
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 10, top: 6, bottom: 6),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.lightGrayColor),
          boxShadow:  [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: .2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(iconPath, height: 33,),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: context.labelMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
              ),
            ),
            AppRadioBtnWithOptionalTitle(
              selectedIndex: _selectedLanguageIndex,
              index: index,
            ),
          ],
        ),
      ),
    );
  }

  
  // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

  void _onLanguageChanged(int index) {
    setState(() => _selectedLanguageIndex = index);
  }

  void _openOnboardingScreen() {
    _applySelectedLocale();
    context.push(AppRoutesPath.onboardingScreen);
  }

  void _onPop() {
    _applySelectedLocale();
    context.pop();
  }

  void _applySelectedLocale() {
    final locale = _selectedLanguageIndex == 0 ? const Locale('de') : const Locale('en');
    Provider.of<LanguageProvider>(context, listen: false).setLocale(locale);
    GetIt.I<UserManager>().setLanguage = _selectedLanguageIndex == 0 ? "de" : "en";
  }
}
