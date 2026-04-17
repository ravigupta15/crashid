import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';

class OnboardingHelper {
  static final localizations = AppLocalizations.of(AppRouter.mainNavigatorKey.currentContext!)!;
  static List list = [
     {
        'img': AppAssetPaths.onboarding1Img,
        'title': localizations.onboardingTitle1,
        'subTitle': localizations.onboardingDes1,
      },
      {
        'img': AppAssetPaths.onboarding2Img,
        'title': localizations.onboardingTitle2,
        'subTitle': localizations.onboardingDes2,
      },
      {
        'img': AppAssetPaths.onboarding3Img,
        'title': localizations.onboardingTitle3,
        'subTitle': localizations.onboardingDes3,
      },
  ];

  
}