import 'dart:io';

import 'package:crashid/core/service/date_picker_service.dart';
import 'package:crashid/core/service/image_picker_service.dart';
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
   TextEditingController _dobController = TextEditingController();
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
      gender: model?.gender,
      websiteLink: model?.websiteLink,
      drivingLicenseFrontUrl: model?.drivingLicenseFront,
      drivingLicenseBackUrl: model?.drivingLicenseBack,
      idDocumentFrontUrl: model?.idDocumentFront,
      idDocumentBackUrl: model?.idDocumentBack
    );

    _dobController = TextEditingController(text: 
    (widget.profileData?.dateOfBirth ?? '').isNotEmpty
     ? DatePickerService.formatForDisplay(DateTime.parse(widget.profileData?.dateOfBirth))
     : '');
    selectedGenderIndex = _initalGenderChanged(widget.profileData?.gender);
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
              initialValue: model?.legalCompanyName,
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
                initialValue: model?.registeredCompanyName,
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
                initialValue: model?.commercialRegistrationNumber,
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
              AppTextFormField(
                initialValue: model?.generalEmail,
                hintText: 'General Company Email',
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
              AppTextFormField(
                initialValue: model?.companyPhone,
                hintText: 'Company Phone Number',
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
              AppTextFormField(
                initialValue: model?.vatId,
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
                  value: model?.industry,
                  key: model?.industry,
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
              initialValue: model?.contactFirstName,
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
              initialValue: model?.contactLastName,
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
              initialValue: model?.jobTitle,
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
                initialValue: model?.contactEmail,
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
                initialValue: model?.contactPhone,
                hintText: 'Primary Phone Number',
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
                      sendModel?.contactPhone = val;
                    }),
              ),
              const SizedBox(height: 24),
                AppTextFormField(
              initialValue: widget.profileData?.websiteLink,
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
                  hintText: "Business Street",
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
                  hintText: "Business House Number",
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
                  hintText: "Business Postal Code",
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
                  hintText: "Business City",
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
             Text("Billing Address", style: Theme.of(context).textTheme.titleMedium,),
             const SizedBox(height: 12),
                AppTextFormField(
                  hintText: "Billing Address",
                textInputAction: TextInputAction.next,
                  inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeWhiteSpace(),
                    ],
                    validator: validateEmpty,
                    onSaved: (val) => setState(() {
                      sendModel?.billingAddress = val;
                    }),
                ),
                const SizedBox(height: 24),
                AppTextFormField(
                  hintText: "Billing Street",
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeWhiteSpace(),
                    ],
                    validator: validateEmpty,
                    onSaved: (val) => setState(() {
                      sendModel?.billingStreet = val;
                    }),
                ),
                const SizedBox(height: 24),
                AppTextFormField(
                  hintText: "Billing House Number",
                   textInputAction: TextInputAction.next,
                  inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeWhiteSpace(),
                    ],
                    validator: validateEmpty,
                    onSaved: (val) => setState(() {
                      sendModel?.billingHouseNumber = val;
                    }),
                
                ),
                const SizedBox(height: 24),
                AppTextFormField(
                  hintText: "Billing Postal Code",
                   textInputAction: TextInputAction.next,
                   textInputType: TextInputType.phone,
                   inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: validateEmpty,
                    onSaved: (val) => setState(() {
                      sendModel?.billingPostalCode = val;
                    }),
                
                ),
                const SizedBox(height: 24),
                AppTextFormField(
                  hintText: "Billing City",
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                      Validator.emojiRestrict(),
                      Validator.removeWhiteSpace(),
                    ],
                    validator: validateEmpty,
                    onSaved: (val) => setState(() {
                      sendModel?.billingCity = val;
                    }),
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
    sendModel?.countryCode = country?.phoneCode;
    if (!_formKey.currentState!.validate()) return;
    if (!_isAllDocumentSelected()) {
      showFeedbackMessage(  
        context: context,
         'Please upload all required documents.',
      );
      return;
    }  else if (sendModel?.selectedInsurancePdf == null) {
      showFeedbackMessage(  
        context: context,
         'Please upload legal form PDF.',
      );
      return;
    }
    _formKey.currentState!.save();
sendModel?.gender = widget.profileData?.gender;
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
    return sendModel?.drivingLicenseFront != null &&
        sendModel?.drivingLicenseBack != null &&
        sendModel?.idDocumentFront != null &&
        sendModel?.idDocumentBack != null;
  }

  // bool _isDocumentUrl() {
  //   return sendModel
  // }
  

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