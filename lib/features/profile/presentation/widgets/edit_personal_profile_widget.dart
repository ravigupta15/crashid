import 'package:crashid/core/service/date_picker_service.dart';
import 'package:crashid/features/profile/model/profile_response_model.dart';
import 'package:crashid/features/profile/model/profile_send_model.dart';
import 'package:crashid/features/profile/provider/profile_notifier.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_radio_button/app_radio_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/features/widgets/country_code_widget.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/utils/country_code_selector.dart';
import 'package:crashid/utils/validators/app_validation.dart';
import 'package:crashid/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditPersonalProfileWidget extends ConsumerStatefulWidget {
  final ProfileModel? profileData;
  const EditPersonalProfileWidget({super.key, this.profileData});

  @override
  ConsumerState<EditPersonalProfileWidget> createState() => _EditPersonalProfileWidgetState();
}

class _EditPersonalProfileWidgetState extends ConsumerState<EditPersonalProfileWidget> with AppValidation, CountryPickerMixin {

  int selectedGenderIndex = 0;

  final _formKey = GlobalKey<FormState>();
   TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDob;


ProfileSendModel? sendModel;

@override
  void initState() {
    _dobController = TextEditingController(text:
    (widget.profileData?.dateOfBirth ?? '').isEmpty
     ? '':
     DatePickerService.formatForDisplay(DateTime.parse(widget.profileData?.dateOfBirth ?? '')));
    selectedGenderIndex = _initalGenderChanged(widget.profileData?.gender);
     Future.microtask(() {
      initCountry(
  phoneCode: (widget.profileData?.countryCode ?? '49').replaceAll('+', '')
);
    });
    sendModel = ProfileSendModel(
      firstName: widget.profileData?.firstName,
      lastName: widget.profileData?.lastName,
      email: widget.profileData?.email,
      mobileNumber: widget.profileData?.mobileNumber,
      address: widget.profileData?.address,
      street: widget.profileData?.street,
      houseNumber: widget.profileData?.houseNumber,
      postalCode: widget.profileData?.postalCode,
      city: widget.profileData?.city,
      countryCode: widget.profileData?.countryCode,
      dob: widget.profileData?.dateOfBirth,
      gender: widget.profileData?.gender
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _screenContent();
  }

  Widget _screenContent() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
              AppTextFormField(
                initialValue: widget.profileData?.firstName,
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
                  initialValue: widget.profileData?.lastName,
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
                  initialValue: widget.profileData?.email,
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
                  initialValue: widget.profileData?.mobileNumber,
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
                AppTextFormField(
                  initialValue: widget.profileData?.address,
                  hintText: AppLocalizations.of(context)!.address,
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
                AppTextFormField(
                  initialValue: widget.profileData?.street,
                  hintText: AppLocalizations.of(context)!.street,
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
                  initialValue: widget.profileData?.houseNumber,
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
                  initialValue: widget.profileData?.postalCode,
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
                AppTextFormField(
                  initialValue: widget.profileData?.city,
                  hintText: AppLocalizations.of(context)!.city,
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
               
        const SizedBox(height: 50,),
        AppElevatedButton.withTitle(title: "Save Changes", onPressed: _checkValidation,)
        ],
      ),
    );
  }

 void _checkValidation() {
    FocusScope.of(context).unfocus();
    sendModel?.countryCode = country?.phoneCode;
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    _editProfileApi();
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

    int _initalGenderChanged(String gender) {
    int index;
    switch (gender) {
      case 'male':
        index = 0;
        break;
      case 'female':
        index = 1;
        break;
      default:
        index = 2;
    }
    return index;
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


void _editProfileApi() async{
    await ref
        .read(profileNotifier.notifier)
        .editProfile(sendModel);
  }
}