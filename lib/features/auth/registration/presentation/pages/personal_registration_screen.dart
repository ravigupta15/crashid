import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_checkbox/app_checkbox_widget.dart';
import 'package:crashid/features/widgets/app_radio_button/app_radio_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/empty/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PersonalRegistrationScreen extends StatefulWidget {
  static void open(BuildContext context) {
    context.push(AppRoutesPath.personalRegisterScreen);
  }

  const PersonalRegistrationScreen({super.key});

  @override
  State<PersonalRegistrationScreen> createState() =>
      _PersonalRegistrationScreenState();
}

class _PersonalRegistrationScreenState
    extends State<PersonalRegistrationScreen> {
  int selectedGenderIndex = 0;
  bool termsAccepted = false;
  bool privacyAccepted = false;

  void _onGenderChanged(int index) {
    setState(() {
      selectedGenderIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidget: EmptyWidget(),
        title: AppLocalizations.of(context)!.personalRegistrationTitle,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.firstName,
              ),

              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.lastName,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Flexible(
                    child: AppTextFormField(
                      hintText: AppLocalizations.of(context)!.dateOfBirth,
                      textInputType: TextInputType.datetime,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First Row: Male and Female
                        Row(
                          children: [
                            AppRadioBtnWithOptionalTitle(
                              selectedIndex: selectedGenderIndex,
                              index: 0,
                              title: AppLocalizations.of(context)!.male,
                              onChanged: _onGenderChanged,
                              isTitleFirst: true,
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: AppRadioBtnWithOptionalTitle(
                                selectedIndex: selectedGenderIndex,
                                index: 1,
                                title: AppLocalizations.of(context)!.female,
                                onChanged: _onGenderChanged,
                                isTitleFirst: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ), // Space before the bottom row
                        // Second Row: Driver
                        AppRadioBtnWithOptionalTitle(
                          selectedIndex: selectedGenderIndex,
                          index: 2,
                          title: AppLocalizations.of(context)!.driver,
                          onChanged: _onGenderChanged,
                          isTitleFirst: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.emailAddress,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.mobileNumber,
                textInputType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _uploadCard(
                    AppLocalizations.of(context)!.drivingLicenseFront,
                  ),
                  const SizedBox(width: 16),
                  _uploadCard(AppLocalizations.of(context)!.drivingLicenseBack),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _uploadCard(AppLocalizations.of(context)!.idDocumentFront),
                  const SizedBox(width: 16),
                  _uploadCard(AppLocalizations.of(context)!.idDocumentBack),
                ],
              ),
              const SizedBox(height: 24),
              AppTextFormField(hintText: AppLocalizations.of(context)!.address),
              const SizedBox(height: 24),
              AppTextFormField(hintText: AppLocalizations.of(context)!.street),
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.houseNumber,
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.postalCode,
              ),
              const SizedBox(height: 24),
              AppTextFormField(hintText: AppLocalizations.of(context)!.city),
              const SizedBox(height: 24),
              AppCheckbox(
                value: termsAccepted,
                onChanged: (value) {
                  setState(() {
                    termsAccepted = value;
                  });
                },
                activeColor: AppColors.primaryColor,
                borderColor: AppColors.darkGrayColor,
                label: AppLocalizations.of(
                  context,
                )!.termsAndConditionsAcceptance,
                labelStyle: context.titleMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 20),
              AppCheckbox(
                value: privacyAccepted,
                onChanged: (value) {
                  setState(() {
                    privacyAccepted = value;
                  });
                },
                activeColor: AppColors.primaryColor,
                borderColor: AppColors.darkGrayColor,
                label: AppLocalizations.of(context)!.privacyPolicyAcceptance,
                labelStyle: context.titleMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(height:48),
              Align(
                alignment: Alignment.center,
                child: AppElevatedButton.withTitle(
                  title: AppLocalizations.of(context)!.register,
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                      text:
                          '${AppLocalizations.of(context)!.alreadyHaveAccount} ',
                      style: context.bodyMedium.copyWith(
                        color: AppColors.darkGrayColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.logIn,
                          style: context.bodyMedium.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _uploadCard(String title) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.bodyMedium.copyWith(
              color: AppColors.darkGrayColor.withValues(alpha: .6),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 92,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: AppColors.lightGrayColor),
              ),
              child: Center(
                child: Image.asset(
                  AppAssetPaths.uploadIcon,
                  height: 38,
                  width: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
