import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/auth/registration/presentation/pages/company_registration_screen.dart';
import 'package:crashid/features/auth/registration/presentation/pages/personal_registration_screen.dart';
import 'package:crashid/features/auth/registration/provider/choose_account_notifier.dart';
import 'package:crashid/features/auth/registration/provider/choose_account_state.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_radio_button/app_radio_button_with_checkIcon.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChooseAccountTypeScreen extends ConsumerStatefulWidget {
  static const kShouldCallApi = "/kShouldCallApi";

  final bool? shouldCallApi;
  static void open(BuildContext context, {bool? shouldCallApi}) {
    context.push(AppRoutesPath.chooseAccountTypeScreen,
    extra: {
      kShouldCallApi: shouldCallApi
    }
    );
  }

  const ChooseAccountTypeScreen({super.key, this.shouldCallApi});

  @override
  ConsumerState<ChooseAccountTypeScreen> createState() => _ChooseAccountTypeScreenState();
}

class _ChooseAccountTypeScreenState extends ConsumerState<ChooseAccountTypeScreen> {
  int selectedIndex = 0;

final chooseProvider =
      AsyncNotifierProvider<ChooseAccountNotifier, ChooseAccountState>(
        ChooseAccountNotifier.new,
      );

  void _onAccountTypeChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenContent(context),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(AppAssetPaths.appLogoIcon, height: 40,),
            ),
            const Spacer(),
            _accountTypeCard(
              index: 0,
              iconPath: AppAssetPaths.personIcon,
              title: AppLocalizations.of(context)!.personalAccountTitle,
              subtitle: AppLocalizations.of(context)!.personalAccountSubtitle,
              onTap: () => _onAccountTypeChanged(0),
            ),
            const SizedBox(height: 16),
            _accountTypeCard(
              index: 1,
              iconPath: AppAssetPaths.companyIcon,
              title: AppLocalizations.of(context)!.companyAccountTitle,
              subtitle: AppLocalizations.of(context)!.companyAccountSubtitle,
              onTap: () => _onAccountTypeChanged(1),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.personalAccountDescription,
              textAlign: TextAlign.center,
              style: context.bodyMedium.copyWith(
                fontSize: 10,
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.companyAccountDescription,
              textAlign: TextAlign.center,
              style: context.bodyMedium.copyWith(
                fontSize: 10,
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(height: 100,),
            AppElevatedButton.withTitle(
              title: AppLocalizations.of(context)!.continueTitle,
              onPressed: widget.shouldCallApi == true ? _callCompleteProfile :
               selectedIndex == 0 ? _openPersonalAccountScreen : _openCompanyAccountScreen,
            ),
          ],
        ),
      ),
    );
  }

  Widget _accountTypeCard({
    required int index,
    required String iconPath,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,
            color: isSelected ? AppColors.lightGrayColor : AppColors.whiteColor,
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 2,
              color: AppColors.blackColor.withValues(alpha: .05)
            )
          ]
        ),
        child: Row(
          children: [
            Container(
              height: 48,width: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ?
                AppColors.primaryColor :
                 AppColors.lightGrayColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                iconPath,
                height: 20,
                width: 18,
                color: isSelected ? AppColors.accentColor : AppColors.blackColor,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.titleMedium.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: context.bodyMedium.copyWith(
                      color: AppColors.darkGrayColor.withValues(alpha: .6),
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15,),
            AppRadioButtonWithCheckicon(
              selectedIndex: selectedIndex,
              index: index,
              onChanged: (_) => _onAccountTypeChanged(index),
            ),
          ],
        ),
      ),
    );
  }

  
  // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------


  void _openPersonalAccountScreen() {
    PersonalRegistrationScreen.open(context);
  }
  void _openCompanyAccountScreen() {
    CompanyRegistrationScreen.open(context);
  }

  void _callCompleteProfile() async {
    await ref
        .read(chooseProvider.notifier)
        .completeProfile(context, accountType: selectedIndex == 0 ? "personal" : "company");
  }
}

