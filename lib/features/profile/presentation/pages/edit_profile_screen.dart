import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/profile/presentation/widgets/company_legal_pdf_info_widget.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_radio_button/app_radio_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/features/widgets/app_textfield/custom_dropdown_widget.dart';
import 'package:crashid/features/widgets/country_code_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/country_code_selector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  static void open(BuildContext context) {
    context.push(AppRoutesPath.editProfileScreen);
  }
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with CountryPickerMixin {

  int selectedGenderIndex = 0;

  @override
  void initState() {
    Future.microtask(() {
      initCountry(phoneCode: "49");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Edit Company Profile",
      ),
      body: _screenContent(),
    );
  }

    // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

Widget _screenContent() {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(left: 20, right: 20,top: 30, bottom: 40),
    child: Column(
      children: [
        AppTextFormField(
          initialValue: "Global Logistics Solutions GmbH",
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "GLS Global",
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "DE123456789",
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "HRB 98765 B",
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "6376487712",prefixWidth: 63,
            prefixIcon: CountryCodeWidget(
              onTap: countryPicker,
              country: country,
            ),
        ),
        const SizedBox(height: 29,),
        CustomDropDownFormFiledWidget(),
        const SizedBox(height: 29,),
        CompanyLegalPdfInfoWidget(),
        Padding(padding: EdgeInsets.symmetric(vertical: 29),
        child: Divider(color: AppColors.blackColor.withValues(alpha: .2),),
        ),
        AppTextFormField(
          initialValue: "Rohit Singh",
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "Solanki",
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "Manager",
        ),
        const SizedBox(height: 29,),
        _EditProfileDocumentRow(frontAsset: "assets/images/License Back.png",
         backAsset: "assets/images/License Back.png",
         onUpdateDocs: (){},
         ),
        const SizedBox(height: 29,),
        _EditProfileDocumentRow(frontAsset: "assets/images/License Back.png",
         backAsset: "assets/images/License Back.png",
         onUpdateDocs: (){},
         ),
         const SizedBox(height: 29,),
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
           
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "6376066019",
          
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "Max MüllerGoethestr. 1280333 München",
          maxLines: 3,
          borderRadius: 10,
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "Goethestr",
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "12",
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "80333",
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "Munchen",
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "Max MüllerGoethestr. 1280333 München",
          maxLines: 3,
          borderRadius: 10,
        ),const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "Goethestr",
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "12",
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "80333",
        ),
        const SizedBox(height: 29,),
        AppTextFormField(
          initialValue: "Munchen",
        ),
        const SizedBox(height: 50,),
        AppElevatedButton.withTitle(title: "Save Changes", onPressed: (){},)
      ],
    ),
  );
}

  void _onGenderChanged(int index) {
    setState(() {
      selectedGenderIndex = index;
    });
  }


}

class _EditProfileDocumentRow extends StatelessWidget {
  const _EditProfileDocumentRow({
    required this.frontAsset,
    required this.backAsset,
    this.onUpdateDocs,
  });

  final String frontAsset;
  final String backAsset;
  final VoidCallback? onUpdateDocs;

  static const double _thumbAspect = 3 / 2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _thumbWithLabel(
                  context,
                  label: 'Front',
                  assetPath: frontAsset,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _thumbWithLabel(
                  context,
                  label: 'Back',
                  assetPath: backAsset,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        AppElevatedButton.withTitle(
          onPressed: onUpdateDocs,
          title: 'Update Docs',
          height: 40,
          width: 104,
          isBoxShadow: false,
          fontSize: 11,
          color: Color(0xff00509D),
          textColor: AppColors.whiteColor,
        ),
      ],
    );
  }

  Widget _thumbWithLabel(
    BuildContext context, {
    required String label,
    required String assetPath,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: context.bodySmall.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.labelMedium,
          ),
        ),
        const SizedBox(height: 6),
        AspectRatio(
          aspectRatio: _thumbAspect,
          child: Image.asset(
            assetPath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ],
    );
  }
}
