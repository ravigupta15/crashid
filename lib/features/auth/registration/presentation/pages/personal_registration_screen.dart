import 'dart:io';

import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/service/date_picker_service.dart';
import 'package:crashid/core/service/image_picker_service.dart';
import 'package:crashid/core/service/location_service.dart';
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
import 'package:crashid/utils/image_picker_bottom_sheet.dart';
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
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  DateTime? _selectedDob;

  RegistrationSendModel? sendModel;
  
  final registrationProvider =
    AsyncNotifierProvider<RegistrationNotifier, RegistrationState>(RegistrationNotifier.new);


  @override
  void initState() {
    sendModel = RegistrationSendModel(
      gender: "male"
    );
    LocationService.getCurrentLocationWithAddress().then((location) {
      setState(() {
        sendModel?.address = location.fullAddress;
        sendModel?.city = location.city;
        sendModel?.street = location.street;
        sendModel?.houseNumber = location.houseNumber;
        sendModel?.postalCode = location.postalCode;

        _addressController.text = location.fullAddress;
        _streetController.text = location.street ?? '';
        _houseNumberController.text = location.houseNumber ?? '';
        _postalCodeController.text = location.postalCode ?? '';
        _cityController.text = location.city ?? '';
      });
    });
    Future.microtask(() {
      initCountry(phoneCode: "49");
     });
    super.initState();
  }

  @override
  void dispose() {
    _dobController.dispose();
    _addressController.dispose();
    _streetController.dispose();
    _houseNumberController.dispose();
    _postalCodeController.dispose();
    _cityController.dispose();
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
                    Validator.removeLeadingWhiteSpace(),
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
                    Validator.removeLeadingWhiteSpace(),
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
              LengthLimitingTextInputFormatter(12)
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
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.address,
                controller: _addressController,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  Validator.emojiRestrict(),
                  Validator.removeLeadingWhiteSpace(),
                ],
                validator: validateEmpty,
                // onChanged: (val) => sendModel?.address = val,
                onSaved: (val) => sendModel?.address = val,
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.street,
                controller: _streetController,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  Validator.emojiRestrict(),
                  Validator.removeLeadingWhiteSpace(),
                ],
                validator: validateEmpty,
                // onChanged: (val) => sendModel?.street = val,
                onSaved: (val) => sendModel?.street = val,
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.houseNumber,
                controller: _houseNumberController,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  Validator.emojiRestrict(),
                  Validator.removeLeadingWhiteSpace(),
                ],
                validator: validateEmpty,
                // onChanged: (val) => sendModel?.houseNumber = val,
                onSaved: (val) => sendModel?.houseNumber = val,
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.postalCode,
                controller: _postalCodeController,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: validateEmpty,
                // onChanged: (val) => sendModel?.postalCode = val,
                onSaved: (val) => sendModel?.postalCode = val,
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context)!.city,
                controller: _cityController,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  Validator.emojiRestrict(),
                  Validator.removeLeadingWhiteSpace(),
                ],
                validator: validateEmpty,
                // onChanged: (val) => sendModel?.city = val,
                onSaved: (val) => sendModel?.city = val,
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

    debugPrint('Registration values: '
      'firstName=${sendModel?.firstName}, '
      'lastName=${sendModel?.lastName}, '
      'dob=${sendModel?.dob}, '
      'gender=${sendModel?.gender}, '
      'email=${sendModel?.email}, '
      'mobileNumber=${sendModel?.mobileNumber}, '
      'countryCode=${sendModel?.countryCode}, '
      'address=${sendModel?.address}, '
      'street=${sendModel?.street}, '
      'houseNumber=${sendModel?.houseNumber}, '
      'postalCode=${sendModel?.postalCode}, '
      'city=${sendModel?.city}, '
      'termsAccepted=${sendModel?.termsAccepted}, '
      'privacyAccepted=${sendModel?.privacyAccepted}, '
      'password=${sendModel?.password}, '
      'confirmPassword=${sendModel?.confirmPassword}, '
      'drivingLicenseFront=${sendModel?.drivingLicenseFront != null}, '
      'drivingLicenseBack=${sendModel?.drivingLicenseBack != null}, '
      'idDocumentFront=${sendModel?.idDocumentFront != null}, '
      'idDocumentBack=${sendModel?.idDocumentBack != null}');

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
    final ImageSource? source = await showImageSourcePicker();
    if (source == null) return;
    final File? file = await ImagePickerService.imagePicker(source);
    if (file == null) return;
    setState(() {
      onPicked(file);
    });
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