import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/auth/registration/model/registration_send_model.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_checkbox/app_checkbox_widget.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/features/widgets/app_textfield/custom_dropdown_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/validators/app_validation.dart';
import 'package:crashid/utils/validators/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CompanyRegistrationScreen extends StatefulWidget {
  static void open(BuildContext context) {
    context.push(AppRoutesPath.companyRegistrationScreen);
  }

  const CompanyRegistrationScreen({super.key});

  @override
  State<CompanyRegistrationScreen> createState() =>
      _CompanyRegistrationScreenState();
}

class _CompanyRegistrationScreenState extends State<CompanyRegistrationScreen> with AppValidation {
    bool termsAccepted = false;
  bool privacyAccepted = false;

final _formKey = GlobalKey<FormState>();
 
 RegistrationSendModel? sendModel;

 @override
  void initState() {
    sendModel = RegistrationSendModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Company Registration"),
      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextFormField(hintText: 'Legal Company Name',
              inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
                  textInputAction: TextInputAction.next,
                  validator: validateEmpty,
                  onSaved: (val) => setState(() {
                    sendModel?.legalCompanyName = val;
                  }),
            ),
            const SizedBox(height: 24),
            AppTextFormField(hintText: 'Registered Company Name (Optional)',
              inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
                  textInputAction: TextInputAction.next,
                  onSaved: (val) => setState(() {
                    sendModel?.registerCompanyName = val;
                  }),
            ),
            const SizedBox(height: 24),
            AppTextFormField(hintText: 'General Company Email',
              inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
                  textInputAction: TextInputAction.next,
                  validator: validateEmail,
                  onSaved: (val) => setState(() {
                    sendModel?.email = val;
                  }),
            ),
            const SizedBox(height: 24),
            AppTextFormField(hintText: 'Company Phone Number',
              inputFormatters: [
                  ],
                  textInputAction: TextInputAction.next,
                  validator: validateEmpty,
                  onSaved: (val) => setState(() {
                    sendModel?.mobileNumber = val;
                  }),
            ),
            const SizedBox(height: 24),
            AppTextFormField(hintText: 'VIT ID',
              inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
                  textInputAction: TextInputAction.next,
                  validator: validateEmpty,
                  onSaved: (val) => setState(() {
                    sendModel?.vitId = val;
                  }),),
            const SizedBox(height: 24),
            CustomDropDownFormFiledWidget(hintText: "Industry Type",),
            const SizedBox(height: 24),
            AppTextFormField(hintText: 'Password'),
            const SizedBox(height: 24),
            AppTextFormField(hintText: 'Comfirm Password'),
            const SizedBox(height: 24,),
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
                          recognizer: TapGestureRecognizer()..onTap = () =>_backToSignIn(),
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
    );
  }
  void _backToSignIn() {
    context.pop();
    context.pop();
  }

}
