import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/core/widget/app_dropdown_item_widget.dart';
import 'package:crashid/features/auth/registration/model/registration_send_model.dart';
import 'package:crashid/features/auth/registration/provider/registration_notifier.dart';
import 'package:crashid/features/auth/registration/provider/registration_state.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_checkbox/app_checkbox_widget.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/features/widgets/app_textfield/custom_dropdown_widget.dart';
import 'package:crashid/features/widgets/country_code_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/country_code_selector.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/validators/app_validation.dart';
import 'package:crashid/utils/validators/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CompanyRegistrationScreen extends ConsumerStatefulWidget {
  static void open(BuildContext context) {
    context.push(AppRoutesPath.companyRegistrationScreen);
  }

  const CompanyRegistrationScreen({super.key});

  @override
  ConsumerState<CompanyRegistrationScreen> createState() =>
      _CompanyRegistrationScreenState();
}

class _CompanyRegistrationScreenState extends ConsumerState<CompanyRegistrationScreen>
    with AppValidation, CountryPickerMixin {

  final _formKey = GlobalKey<FormState>();
  RegistrationSendModel? sendModel;
  final registrationProvider =
      AsyncNotifierProvider<RegistrationNotifier, RegistrationState>(
        RegistrationNotifier.new,
      );

  @override
  void initState() {
    sendModel = RegistrationSendModel(
      termsAccepted: false,
      privacyAccepted: false,
    );
    Future.microtask(() {
      initCountry(phoneCode: "49");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Company Registration",isShowAction: false,),
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
              prefixWidth: 63,
            prefixIcon: CountryCodeWidget(
              onTap: countryPicker,
              country: country,
            ),
            textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10)
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
            CustomDropDownFormFiledWidget(
              hintText: "Industry Type",
              items: AppDropdownItemWidget.industryTypeList,
              onSaved: (newValue) {
                setState(() {
                  sendModel?.industryType = newValue?.value;
                });
              },
              validator: (val) {
                if (val == null ) {
                  return 'Required';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            AppTextFormField(
              hintText: 'Password',
              obscure: (sendModel?.password ?? '').isNotEmpty,
              inputFormatters: [
                Validator.emojiRestrict(),
                Validator.removeWhiteSpace(),
              ],
              validator: validatePassword,
              onChanged: (val) => setState(() {
                sendModel?.password = val;
              }),
            ),
            const SizedBox(height: 24),
            AppTextFormField(
              hintText: 'Comfirm Password',
              obscure: (sendModel?.confirmPassword ?? '').isNotEmpty,
              inputFormatters: [
                Validator.emojiRestrict(),
                Validator.removeWhiteSpace(),
              ],
              validator: (val) => validateConfirmPassword(val, sendModel?.password),
              onChanged: (val) => setState(() {
                sendModel?.confirmPassword = val;
              }),
            ),
            const SizedBox(height: 24,),
             AppCheckbox(
                value: sendModel?.termsAccepted ?? false,
                onChanged: (value) {
                  setState(() {
                    sendModel?.termsAccepted = value;
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
                value: sendModel?.privacyAccepted ?? false,
                onChanged: (value) {
                  setState(() {
                    sendModel?.privacyAccepted = value;
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
                  onPressed: _checkValidation,
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

  void _checkValidation() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (!(sendModel?.termsAccepted ?? false)) {
      showFeedbackMessage(
        'Please accept the terms and conditions.',
        context: context,
      );
      return;
    }
    if (!(sendModel?.privacyAccepted ?? false)) {
      showFeedbackMessage(
        'Please accept the privacy policy.',
        context: context,
      );
      return;
    }
    
    sendModel?.countryCode = country?.phoneCode;
    _formKey.currentState!.save();
    _callCompanyAccountApi();
  }

  void _callCompanyAccountApi() async {
    await ref
        .read(registrationProvider.notifier)
        .companyRegistration(context, sendModel: sendModel);
  }
}