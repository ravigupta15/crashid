import 'dart:io';

import 'package:crashid/core/service/date_picker_service.dart';
import 'package:crashid/core/service/image_picker_service.dart';
import 'package:crashid/core/service/location_service.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/core/widget/app_dropdown_item_widget.dart';
import 'package:crashid/features/auth/registration/presentation/widgets/upload_card_widget.dart';
import 'package:crashid/features/profile/model/profile_response_model.dart';
import 'package:crashid/features/profile/model/profile_send_model.dart';
import 'package:crashid/features/profile/presentation/widgets/company_legal_pdf_info_widget.dart';
import 'package:crashid/features/profile/provider/profile_notifier.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_radio_button/app_radio_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/features/widgets/app_textfield/custom_dropdown_widget.dart';
import 'package:crashid/features/widgets/country_code_widget.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/country_code_selector.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/image_picker_bottom_sheet.dart';
import 'package:crashid/utils/validators/app_validation.dart';
import 'package:crashid/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

  class EditCompanyProfileWidget extends ConsumerStatefulWidget {
    final ProfileModel? profileData;
  const EditCompanyProfileWidget({super.key, this.profileData});

  @override
  ConsumerState<EditCompanyProfileWidget> createState() => _EditCompanyProfileWidgetState();
}

class _EditCompanyProfileWidgetState extends ConsumerState<EditCompanyProfileWidget> with AppValidation, CountryPickerMixin{


  int selectedGenderIndex = 0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _businessAddressController = TextEditingController();
  final TextEditingController _businessStreetController = TextEditingController();
  final TextEditingController _businessHouseNumberController = TextEditingController();
  final TextEditingController _businessPostalCodeController = TextEditingController();
  final TextEditingController _businessCityController = TextEditingController();
  final TextEditingController _billingAddressController = TextEditingController();
  final TextEditingController _billingStreetController = TextEditingController();
  final TextEditingController _billingHouseNumberController = TextEditingController();
  final TextEditingController _billingPostalCodeController = TextEditingController();
  final TextEditingController _billingCityController = TextEditingController();
  DateTime? _selectedDob;


ProfileSendModel? sendModel;
  
  @override
 void initState() {
    super.initState();
    var model = widget.profileData;
    sendModel = ProfileSendModel(
      accountType: model?.accountType,
      legalCompanyName: model?.legalCompanyName,
      registerCompanyName: model?.registeredCompanyName,
      vitId: model?.vatId,
      commercialRegNumber: model?.commercialRegistrationNumber,
      email: model?.generalEmail,
      countryCode: (model?.countryCode ?? '49').replaceAll('+', ''),
      mobileNumber: model?.companyPhone,
      industryType: model?.industry,
      contactFirstName: model?.contactFirstName,
      contactLastName: model?.contactLastName,
      contactEmail: model?.contactEmail,
      contactPhone: model?.contactPhone,
      dob: model?.dateOfBirth,
      gender: (model?.gender ?? '').toString().isEmpty ? 'male' : model?.gender,
      websiteLink: model?.websiteLink,
      drivingLicenseFrontUrl: model?.drivingLicenseFront,
      drivingLicenseBackUrl: model?.drivingLicenseBack,
      idDocumentFrontUrl: model?.idDocumentFront,
      idDocumentBackUrl: model?.idDocumentBack,
      businessAddress: model?.businessAddress,
      businessStreet: model?.businessStreet,
      businessHouseNumber: model?.businessHouseNumber,
      businessPostalCode: model?.businessPostalCode,
      businessCity: model?.businessCity,
      billingAddress: model?.billingAddress,
      billingStreet: model?.billingStreet,
      billingHouseNumber: model?.billingHouseNumber,
      billingPostalCode: model?.billingPostalCode,
      billingCity: model?.billingCity,
      jobTitle: model?.jobTitle
    );

    _dobController.text = (widget.profileData?.dateOfBirth ?? '').isNotEmpty
        ? DatePickerService.formatForDisplay(DateTime.parse(widget.profileData?.dateOfBirth!))
        : '';
    selectedGenderIndex = _initalGenderChanged(widget.profileData?.gender);

    _businessAddressController.text = model?.businessAddress ?? '';
    _businessStreetController.text = model?.businessStreet ?? '';
    _businessHouseNumberController.text = model?.businessHouseNumber ?? '';
    _businessPostalCodeController.text = model?.businessPostalCode ?? '';
    _businessCityController.text = model?.businessCity ?? '';

    _billingAddressController.text = model?.billingAddress ?? '';
    _billingStreetController.text = model?.billingStreet ?? '';
    _billingHouseNumberController.text = model?.billingHouseNumber ?? '';
    _billingPostalCodeController.text = model?.billingPostalCode ?? '';
    _billingCityController.text = model?.billingCity ?? '';

    final shouldFetchLocation = [
      model?.businessAddress,
      model?.businessStreet,
      model?.businessHouseNumber,
      model?.businessPostalCode,
      model?.businessCity,
      model?.billingAddress,
      model?.billingStreet,
      model?.billingHouseNumber,
      model?.billingPostalCode,
      model?.billingCity,
    ].any((value) => value == null || value.toString().isEmpty);

    if (shouldFetchLocation) {
      LocationService.getCurrentLocationWithAddress().then((location) {
        if (!mounted) return;
        setState(() {
          if ((sendModel?.businessAddress ?? '').isEmpty) {
            sendModel?.businessAddress = location.fullAddress;
            _businessAddressController.text = location.fullAddress;
          }
          if ((sendModel?.businessStreet ?? '').isEmpty) {
            sendModel?.businessStreet = location.street;
            _businessStreetController.text = location.street ?? '';
          }
          if ((sendModel?.businessHouseNumber ?? '').isEmpty) {
            sendModel?.businessHouseNumber = location.houseNumber;
            _businessHouseNumberController.text = location.houseNumber ?? '';
          }
          if ((sendModel?.businessPostalCode ?? '').isEmpty) {
            sendModel?.businessPostalCode = location.postalCode;
            _businessPostalCodeController.text = location.postalCode ?? '';
          }
          if ((sendModel?.businessCity ?? '').isEmpty) {
            sendModel?.businessCity = location.city;
            _businessCityController.text = location.city ?? '';
          }

          if ((sendModel?.billingAddress ?? '').isEmpty) {
            sendModel?.billingAddress = location.fullAddress;
            _billingAddressController.text = location.fullAddress;
          }
          if ((sendModel?.billingStreet ?? '').isEmpty) {
            sendModel?.billingStreet = location.street;
            _billingStreetController.text = location.street ?? '';
          }
          if ((sendModel?.billingHouseNumber ?? '').isEmpty) {
            sendModel?.billingHouseNumber = location.houseNumber;
            _billingHouseNumberController.text = location.houseNumber ?? '';
          }
          if ((sendModel?.billingPostalCode ?? '').isEmpty) {
            sendModel?.billingPostalCode = location.postalCode;
            _billingPostalCodeController.text = location.postalCode ?? '';
          }
          if ((sendModel?.billingCity ?? '').isEmpty) {
            sendModel?.billingCity = location.city;
            _billingCityController.text = location.city ?? '';
          }
        });
      }).catchError((error) {
        print('EditCompanyProfileWidget: location fetch failed: $error');
      });
    }

    Future.microtask(() {
      initCountry(
     phoneCode: (widget.profileData?.countryCode ?? '49').replaceAll('+', '')
   );
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return _screenContent();
  }

  Widget _screenContent() {
    var model = widget.profileData;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             AppTextFormField(
              initialValue: sendModel?.legalCompanyName,
              hintText: 'Legal Company Name',
                inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    textInputAction: TextInputAction.next,
                    validator: validateEmpty,
                    onSaved: (val) => setState(() {
                      sendModel?.legalCompanyName = val;
                    }),
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                initialValue: sendModel?.registerCompanyName,
                hintText: 'Registered Company Name (Optional)',
                inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    textInputAction: TextInputAction.next,
                    onSaved: (val) => setState(() {
                      sendModel?.registerCompanyName = val;
                    }),
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                initialValue: sendModel?.commercialRegNumber,
                hintText: 'Commercial Registered Number',
                inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    textInputAction: TextInputAction.next,
                    onSaved: (val) => setState(() {
                      sendModel?.commercialRegNumber = val;
                    }),
              ),
              const SizedBox(height: 24),
                // AppTextFormField(
                //   initialValue: sendModel?.email,
                //   hintText: 'General Company Email',
                //   inputFormatters: [
                //         Validator.emojiRestrict(),
                //         Validator.removeWhiteSpace(),
                //       ],
                //       textInputAction: TextInputAction.next,
                //       validator: validateEmail,
                //       onSaved: (val) => setState(() {
                //         sendModel?.email = val;
                //       }),
                // ),
                // const SizedBox(height: 24),
              AppTextFormField(
                initialValue: sendModel?.mobileNumber,
                hintText: 'Company Phone Number',
                prefixWidth: 63,
              prefixIcon: CountryCodeWidget(
                onTap: countryPicker,
                country: country,
              ),
              textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12)
                    ],
                    textInputAction: TextInputAction.next,
                    validator: validateEmpty,
                    onSaved: (val) => setState(() {
                      sendModel?.mobileNumber = val;
                    }),
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                initialValue: sendModel?.vitId,
                hintText: 'VIT ID',
                inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    textInputAction: TextInputAction.next,
                    validator: validateEmpty,
                    onSaved: (val) => setState(() {
                      sendModel?.vitId = val;
                    }),),
              const SizedBox(height: 24),
              CustomDropDownFormFiledWidget(
                hintText: "Industry Type",
                selectedValue: CustomDropDownItem(
                  value: sendModel?.industryType ?? '',
                  key: sendModel?.industryType ?? '',
                 ),
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
              (model?.legalFormPdf ?? '').toString().isNotEmpty ?
              CompanyLegalPdfInfoWidget() :
              AppTextFormField(
                isReadOnly: true,
                hintText: "Legal Form PDF",
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Image.asset(
                  AppAssetPaths.uploadIcon,
                  width: 50,
                  height: 38,
                  ),
                ),
                onTap: _pickInsurancePdf,
                
              ),
              if (sendModel?.selectedInsurancePdf != null) ...[
              const SizedBox(height: 10),
              _selectedPdfWidget(),
            ],
          
              // CompanyLegalPdfInfoWidget(),
              const SizedBox(height: 24),
                AppTextFormField(
              initialValue:   sendModel?.contactFirstName,
              hintText: 'Primary First Name',
                inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    textInputAction: TextInputAction.next,
                    validator: validateEmpty,
                    onSaved: (val) => setState(() {
                      sendModel?.contactFirstName = val;
                    }),
              ),
              
              const SizedBox(height: 24),
                AppTextFormField(
              initialValue: sendModel?.contactLastName,
              hintText: 'Primary Last Name',
                inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    textInputAction: TextInputAction.next,
                    validator: validateEmpty,
                    onSaved: (val) => setState(() {
                      sendModel?.contactLastName = val;
                    }),
              ),
              
              const SizedBox(height: 24),
                AppTextFormField(
              initialValue: sendModel?.jobTitle,
              hintText: 'Job Title',
                inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    textInputAction: TextInputAction.next,
                    validator: validateEmpty,
                    onSaved: (val) => setState(() {
                      sendModel?.jobTitle = val;
                    }),
              ),
               const SizedBox(height: 24),
              AppTextFormField(
                initialValue: sendModel?.contactEmail,
                hintText: 'Contact Email',
                inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeWhiteSpace(),
                    ],
                    textInputAction: TextInputAction.next,
                    validator: validateEmail,
                    onSaved: (val) => setState(() {
                      sendModel?.contactEmail = val;
                    }),
              ),
             
              const SizedBox(height: 24),
              Row(
                children: [
                  UploadCardWidget(
                    title:
                    AppLocalizations.of(context)!.drivingLicenseFront,
                    hasFile: sendModel?.drivingLicenseFront,
                    imgUrl: model?.drivingLicenseFront,
                    onTap: () => _pickDocumentImage(
                      onPicked: (file) => sendModel?.drivingLicenseFront = file,
                    ),
                  ),
                  const SizedBox(width: 16),
                  UploadCardWidget(
                    title: AppLocalizations.of(context)!.drivingLicenseBack,
                    hasFile: sendModel?.drivingLicenseBack,
                    imgUrl: model?.drivingLicenseBack,
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
                    imgUrl: model?.idDocumentFront,
                    onTap: () => _pickDocumentImage(
                      onPicked: (file) => sendModel?.idDocumentFront = file,
                    ),
                  ),
                  const SizedBox(width: 16),
                  UploadCardWidget(
                    title: AppLocalizations.of(context)!.idDocumentBack,
                    hasFile: sendModel?.idDocumentBack,
                    imgUrl: model?.idDocumentBack,
                    onTap: () => _pickDocumentImage(
                      onPicked: (file) => sendModel?.idDocumentBack = file,
                    ),
                  ),
                ],
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
              const SizedBox(height: 24,),
           AppTextFormField(
                initialValue: sendModel?.contactPhone,
                hintText: 'Primary Phone Number',
                prefixWidth: 63,
              prefixIcon: CountryCodeWidget(
                onTap: countryPicker,
                country: country,
              ),
              textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12)
                    ],
                    textInputAction: TextInputAction.next,
                    validator: validateEmpty,
                    onSaved: (val) => setState(() {
                      sendModel?.contactPhone = val;
                    }),
              ),
              const SizedBox(height: 24),
                AppTextFormField(
              initialValue: sendModel?.websiteLink,
              hintText: 'Website link',
                inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeWhiteSpace(),
                    ],
                    textInputAction: TextInputAction.next,
                    validator: validateEmpty,
                    onSaved: (val) => setState(() {
                      sendModel?.websiteLink = val;
                    }),
              ),
             const SizedBox(height: 24),
             Text("Business Address", style: Theme.of(context).textTheme.titleMedium,),
             const SizedBox(height: 12),
                AppTextFormField(
                  hintText: "Business Address",
                  controller: _businessAddressController,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    validator: validateEmpty,
                    onChanged: (val) => sendModel?.businessAddress = val,
                    onSaved: (val) => sendModel?.businessAddress = val,
                ),
                const SizedBox(height: 24),
                AppTextFormField(
                  hintText: "Business Street",
                  controller: _businessStreetController,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    validator: validateEmpty,
                    onChanged: (val) => sendModel?.businessStreet = val,
                    onSaved: (val) => sendModel?.businessStreet = val,
                ),
                const SizedBox(height: 24),
                AppTextFormField(
                  hintText: "Business House Number",
                  controller: _businessHouseNumberController,
                   textInputAction: TextInputAction.next,
                  inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    validator: validateEmpty,
                    onChanged: (val) => sendModel?.businessHouseNumber = val,
                    onSaved: (val) => sendModel?.businessHouseNumber = val,
                
                ),
                const SizedBox(height: 24),
                AppTextFormField(
                  hintText: "Business Postal Code",
                  controller: _businessPostalCodeController,
                   textInputAction: TextInputAction.next,
                   textInputType: TextInputType.phone,
                   inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6)
                    ],
                    validator: validateEmpty,
                    onChanged: (val) => sendModel?.businessPostalCode = val,
                    onSaved: (val) => sendModel?.businessPostalCode = val,
                
                ),
                const SizedBox(height: 24),
                AppTextFormField(
                  hintText: "Business City",
                  controller: _businessCityController,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    validator: validateEmpty,
                    onChanged: (val) => sendModel?.businessCity = val,
                    onSaved: (val) => sendModel?.businessCity = val,
                ),
             const SizedBox(height: 24),
             Text("Billing Address", style: Theme.of(context).textTheme.titleMedium,),
             const SizedBox(height: 12),
                AppTextFormField(
                  hintText: "Billing Address",
                  controller: _billingAddressController,
                textInputAction: TextInputAction.next,
                  inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    validator: validateEmpty,
                    onChanged: (val) => sendModel?.billingAddress = val,
                    onSaved: (val) => sendModel?.billingAddress = val,
                ),
                const SizedBox(height: 24),
                AppTextFormField(
                  hintText: "Billing Street",
                  controller: _billingStreetController,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    validator: validateEmpty,
                    onChanged: (val) => sendModel?.billingStreet = val,
                    onSaved: (val) => sendModel?.billingStreet = val,
                ),
                const SizedBox(height: 24),
                AppTextFormField(
                  hintText: "Billing House Number",                  controller: _billingHouseNumberController,                   textInputAction: TextInputAction.next,
                  inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    validator: validateEmpty,
                    onChanged: (val) => sendModel?.billingHouseNumber = val,
                    onSaved: (val) => sendModel?.billingHouseNumber = val,
                
                ),
                const SizedBox(height: 24),
                AppTextFormField(
                  hintText: "Billing Postal Code",                  controller: _billingPostalCodeController,                   textInputAction: TextInputAction.next,
                   textInputType: TextInputType.phone,
                   inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6)
                    ],
                    validator: validateEmpty,
                    onChanged: (val) => sendModel?.billingPostalCode = val,
                    onSaved: (val) => sendModel?.billingPostalCode = val,
                
                ),
                const SizedBox(height: 24),
                AppTextFormField(
                  hintText: "Billing City",
                  controller: _billingCityController,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeLeadingWhiteSpace(),
                    ],
                    validator: validateEmpty,
                    onChanged: (val) => sendModel?.billingCity = val,
                    onSaved: (val) => sendModel?.billingCity = val,
                ),
               const SizedBox(height: 50,),
               
        Align(
          alignment: Alignment.center,
          child: AppElevatedButton.withTitle(title: "Save Changes", onPressed: _checkValidation,))
        ],
      ),
    );
  }

   Widget _selectedPdfWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrayColor),
      ),
      child: Row(
        children: [
          Icon(Icons.picture_as_pdf, color: AppColors.primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _fileNameFromPath(sendModel?.selectedInsurancePdf?.path ?? ''),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGrayColor,
              ),
            ),
          ),
          InkWell(
            onTap: _removeInsurancePdf,
            child: const Icon(Icons.close, size: 18),
          ),
        ],
      ),
    );
  }


 Future<void> _pickInsurancePdf() async {
    final file = await ImagePickerService.pickPdfFile();
    if (file == null) return;
    setState(() {
      sendModel?.selectedInsurancePdf = file;
    });
  }

   void _removeInsurancePdf() {
    setState(() {
      sendModel?.selectedInsurancePdf = null;
    });
  }

  String _fileNameFromPath(String path) {
    if (path.isEmpty) return '';
    return path.split(Platform.pathSeparator).last;
  }


   void _checkValidation() {
    FocusScope.of(context).unfocus();
    print(sendModel?.gender);
    sendModel?.countryCode = country?.phoneCode;
    if (!_formKey.currentState!.validate()) return;
    if (!_isAllDocumentSelected()) {
      showFeedbackMessage(  
        context: context,
         'Please upload all required documents.',
      );
      return;
    }  else if (!_isLegalPdfValid()) {
      showFeedbackMessage(  
        context: context,
         'Please upload legal form PDF.',
      );
      return;
    }
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

    int _initalGenderChanged(String? gender) {
    int index;
    switch (gender) {
      case 'male':
        index = 0;
        break;
      case 'female':
        index = 1;
        break;
      case 'divers':
        index = 2;  
      default:
        index = 0;
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

bool _isAllDocumentSelected() {
  // Driving License Front: either has new file OR existing URL
  final hasDrivingFront = sendModel?.drivingLicenseFront != null || 
      (sendModel?.drivingLicenseFrontUrl?.isNotEmpty ?? false);
  
  // Driving License Back: either has new file OR existing URL
  final hasDrivingBack = sendModel?.drivingLicenseBack != null || 
      (sendModel?.drivingLicenseBackUrl?.isNotEmpty ?? false);
  
  // ID Document Front: either has new file OR existing URL
  final hasIdFront = sendModel?.idDocumentFront != null || 
      (sendModel?.idDocumentFrontUrl?.isNotEmpty ?? false);
  
  // ID Document Back: either has new file OR existing URL
  final hasIdBack = sendModel?.idDocumentBack != null || 
      (sendModel?.idDocumentBackUrl?.isNotEmpty ?? false);
  
  return hasDrivingFront && hasDrivingBack && hasIdFront && hasIdBack;
}

bool _isLegalPdfValid() {
  // Legal PDF: either has new file OR existing URL
  final hasNewPdf = sendModel?.selectedInsurancePdf != null;
  final hasExistingUrl = (widget.profileData?.legalFormPdf ?? '').isNotEmpty;
  
  return hasNewPdf || hasExistingUrl;
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


void _editProfileApi() async{
    await ref
        .read(profileNotifier.notifier)
        .editProfile(sendModel);
  }

}