import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class CheckEmailWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const CheckEmailWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return _screenContent(context);
  }

    // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------
 

Widget _screenContent(BuildContext context) {
return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(AppAssetPaths.passwordLockIcon, height: 50,),
      const SizedBox(height: 10,),
      Text(AppLocalizations.of(context)!.checkYourEmail, style: context.titleMedium.copyWith(
        fontSize: 20, fontWeight: FontWeight.w700
      ),),
      const SizedBox(height: 10,),
      Text(AppLocalizations.of(context)!.otpSentDescription, 
      textAlign: TextAlign.center,
      style: context.bodyMedium.copyWith(
        fontSize: 12, color: AppColors.darkGrayColor.withValues(alpha: .6),
      ),
      ),
      const SizedBox(height: 23,),
      AppElevatedButton.withTitle(title: AppLocalizations.of(context)!.enterOtp, onPressed: onTap,)
    ],
  ),
);
}
}