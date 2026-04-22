import 'dart:io';

import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/service/date_picker_service.dart';
import 'package:crashid/core/service/image_picker_service.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/features/auth/registration/model/registration_send_model.dart';
import 'package:crashid/features/auth/registration/presentation/widgets/upload_card_widget.dart';
import 'package:crashid/features/auth/registration/provider/registration_notifier.dart';
import 'package:crashid/features/auth/registration/provider/registration_state.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_checkbox/app_checkbox_widget.dart';
import 'package:crashid/features/widgets/app_radio_button/app_radio_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
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
import 'package:image_picker/image_picker.dart';

class PersonalRegistrationScreen extends ConsumerStatefulWidget {
  static void open(BuildContext context) {
    context.push(AppRoutesPath.personalRegisterScreen);
  }

  const PersonalRegistrationScreen({super.key});

  @override
  ConsumerState<PersonalRegistrationScreen> createState() =>
      _PersonalRegistrationScreenState();
}

class _PersonalRegistrationScreenState
    extends ConsumerState<PersonalRegistrationScreen> with AppValidation, CountryPickerMixin {
  int selectedGenderIndex = 0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDob;

  RegistrationSendModel? sendModel;
  
  final registrationProvider =
    AsyncNotifierProvider<RegistrationNotifier, RegistrationState>(RegistrationNotifier.new);


  @override
  void initState() {
    sendModel = RegistrationSendModel(
      gender: "male"
    );
    Future.microtask(() {
      initCountry(phoneCode: "49");
    });
    super.initState();
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isShowAction: false,
        title: AppLocalizations.of(context)!.personalRegistrationTitle,
      ),
      body: _screenContent()
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
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.firstName,
                  inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
                  textInputAction: TextInputAction.next,
                  validator: validateEmpty,
                  onSaved: (val) => setState(() {
                    sendModel?.firstName = val;
                  }),
              ),
          
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.lastName,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
                  validator: validateEmpty,
                  onSaved: (val) => setState(() {
                    sendModel?.lastName = val;
                  }),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Flexible(
                    child: AppTextFormField(
                      hintText: AppLocalizations.of(context)!.dateOfBirth,
                      controller: _dobController,
                      textInputType: TextInputType.datetime,
                      isReadOnly: true,
                      validator: validateEmpty,
                      onTap: _pickDob,
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
                          title: "Divers",
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
                textInputAction: TextInputAction.next,
                inputFormatters: [
                    FilteringTextInputFormatter.allow(Validator.regEmail),
                ],
                validator: validateEmail,
                onSaved: (val) => setState(() {
                    sendModel?.email = val;
                  }),
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.mobileNumber,
                  prefixWidth: 63,
            prefixIcon: CountryCodeWidget(
              onTap: countryPicker,
              country: country,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: validateEmpty,
                onSaved: (val) => setState(() {
                    sendModel?.mobileNumber = val;
                  }),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  UploadCardWidget(
                    title:
                    AppLocalizations.of(context)!.drivingLicenseFront,
                    hasFile: sendModel?.drivingLicenseFront,
                    onTap: () => _pickDocumentImage(
                      onPicked: (file) => sendModel?.drivingLicenseFront = file,
                    ),
                  ),
                  const SizedBox(width: 16),
                  UploadCardWidget(
                    title: AppLocalizations.of(context)!.drivingLicenseBack,
                    hasFile: sendModel?.drivingLicenseBack,
                    onTap: () => _pickDocumentImage(
                      onPicked: (file) => sendModel?.drivingLicenseBack = file,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  UploadCardWidget(
                    title: AppLocalizations.of(context)!.idDocumentFront,
                    hasFile: sendModel?.idDocumentFront,
                    onTap: () => _pickDocumentImage(
                      onPicked: (file) => sendModel?.idDocumentFront = file,
                    ),
                  ),
                  const SizedBox(width: 16),
                  UploadCardWidget(
                    title: AppLocalizations.of(context)!.idDocumentBack,
                    hasFile: sendModel?.idDocumentBack,
                    onTap: () => _pickDocumentImage(
                      onPicked: (file) => sendModel?.idDocumentBack = file,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AppTextFormField(hintText: AppLocalizations.of(context)!.address,
              textInputAction: TextInputAction.next,
                inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
                  validator: validateEmpty,
                  onSaved: (val) => setState(() {
                    sendModel?.address = val;
                  }),
              ),
              const SizedBox(height: 24),
              AppTextFormField(hintText: AppLocalizations.of(context)!.street,
              textInputAction: TextInputAction.next,
                inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
                  validator: validateEmpty,
                  onSaved: (val) => setState(() {
                    sendModel?.street = val;
                  }),
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.houseNumber,
                 textInputAction: TextInputAction.next,
                inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
                  validator: validateEmpty,
                  onSaved: (val) => setState(() {
                    sendModel?.houseNumber = val;
                  }),
              
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.postalCode,
                 textInputAction: TextInputAction.next,
                 textInputType: TextInputType.phone,
                 inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: validateEmpty,
                  onSaved: (val) => setState(() {
                    sendModel?.postalCode = val;
                  }),
              
              ),
              const SizedBox(height: 24),
              AppTextFormField(hintText: AppLocalizations.of(context)!.city,
               textInputAction: TextInputAction.done,
                inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
                  validator: validateEmpty,
                  onSaved: (val) => setState(() {
                    sendModel?.city = val;
                  }),
              
              ),
              const SizedBox(height: 24),
               AppTextFormField(
              obscure: (sendModel?.password ?? '').isEmpty ? false : true,
               inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
              hintText: "Password", 
                textInputAction: TextInputAction.done,
                initialValue: sendModel?.password,
                validator: validatePassword,
                onChanged: (val) => setState(() {
                  sendModel?.password = val;
                }),
              
            ),
            const SizedBox(height: 24,),
            AppTextFormField(
               obscure: (sendModel?.confirmPassword ?? '').isEmpty ? false : true,
               inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
             
              hintText: AppLocalizations.of(context)!.confirmPassword,
                textInputAction: TextInputAction.done,
                initialValue: sendModel?.password,
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
  
  void _onGenderChanged(int index) {
    setState(() {
      selectedGenderIndex = index;
      if (index == 0) {
        sendModel?.gender = 'male';
      } else if (index == 1) {
        sendModel?.gender = 'female';
      } else {
        sendModel?.gender = 'divers';
      }
    });
  }

  void _checkValidation() {
    FocusScope.of(context).unfocus();
    sendModel?.countryCode = country?.phoneCode;
    if (!_formKey.currentState!.validate()) return;
    if (!_isAllDocumentSelected()) {
      showFeedbackMessage(  
        context: context,
         'Please upload all required documents.',
        
      );
      return;
    } else if (sendModel?.termsAccepted != true) {
      showFeedbackMessage(
        context: context,
         'Please accept the terms and conditions.',
      );
      return;
    } else if (sendModel?.privacyAccepted != true) {
      showFeedbackMessage(context: context, 
       'Please accept the privacy policy.',
      );
      return;
    }
    _formKey.currentState!.save();
    _callPersonalAccountApi();
  }

  Future<void> _pickDob() async {
    final DateTime? pickedDate = await DatePickerService.pickDob(
      context,
      initialDate: _selectedDob,
    );
    if (pickedDate == null) return;

    setState(() {
      _selectedDob = pickedDate;
      _dobController.text = DatePickerService.formatForDisplay(pickedDate);
      sendModel?.dob = DatePickerService.formatForApi(pickedDate);
    });
  }

  bool _isAllDocumentSelected() {
    return sendModel?.drivingLicenseFront != null &&
        sendModel?.drivingLicenseBack != null &&
        sendModel?.idDocumentFront != null &&
        sendModel?.idDocumentBack != null;
  }

  Future<void> _pickDocumentImage({
    required ValueChanged<File?> onPicked,
  }) async {
    final ImageSource? source = await _showImageSourcePicker();
    if (source == null) return;
    final File? file = await ImagePickerService.imagePicker(source);
    if (file == null) return;
    setState(() {
      onPicked(file);
    });
  }

  Future<ImageSource?> _showImageSourcePicker() {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title:  Text('Gallery', style: context.bodyMedium.copyWith(
                  color: AppColors.darkGrayColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                )),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title:  Text('Camera', style: context.bodyMedium.copyWith(
                  color: AppColors.darkGrayColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                )),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );
  }

  void _backToSignIn() {
    context.pop();
    context.pop();
  }


  void _callPersonalAccountApi() async{
    await ref
        .read(registrationProvider.notifier)
        .personalRegistration(context, sendModel: sendModel);
  }
}