import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/core/utils/address_formatter.dart';
import 'package:crashid/features/profile/model/profile_response_model.dart';
import 'package:crashid/features/profile/presentation/widgets/company_legal_pdf_info_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_document_pair_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_info_card_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_labeled_block_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_section_header_widget.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_cached_network/app_cached_network_images.dart';
import 'package:crashid/utils/date_format/app_date_format.dart';
import 'package:crashid/utils/empty/empty_widget.dart';
import 'package:crashid/utils/linkers/launch_url.dart';
import 'package:flutter/material.dart';

class CompanyAccountWidget extends StatefulWidget {
  final ProfileModel? profileData;

  const CompanyAccountWidget({super.key, this.profileData});

  @override
  State<CompanyAccountWidget> createState() => _CompanyAccountWidgetState();
}

class _CompanyAccountWidgetState extends State<CompanyAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return _screenContent();
  }

  Widget _screenContent() {
    var model = widget.profileData;
    return Column(
      children: [
        ProfileSectionHeader(
          icon: Image.asset(AppAssetPaths.sericeGridIcon),
          title: 'Company Information',
        ),
        const SizedBox(height: 12),
        ProfileInfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileLabeledBlock(
                label: 'Legal company name',
                value: model?.legalCompanyName,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Registered name',
                value: model?.registeredCompanyName,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'VAT ID',
                value: model?.vatId,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Comm. reg. number',
                value: model?.commercialRegistrationNumber,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Company email',
                value: model?.generalEmail,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Company phone number',
                value: "${model?.countryCode ?? ''} ${model?.companyPhone ?? ''}",
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(label: 'Industry', value: model?.industry),
              if (model?.legalFormPdf != null)...[ 
              const SizedBox(height: 20),
              CompanyLegalPdfInfoWidget(
                onClick: () {
                  // LaunchURLUtils().launchStringURL(url);
                },
              ),
              ]
            ],
          ),
        ),
        const SizedBox(height: 32),
        ProfileSectionHeader(
          icon: Image.asset(AppAssetPaths.userDetailsIcon),
          title: 'Primary Contact Person',
        ),
        const SizedBox(height: 12),
        ProfileInfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileLabeledBlock(
                label: 'Full name',
                value: "${model?.contactFirstName} ${model?.contactLastName}",
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Job title',
                value: model?.jobTitle,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Email address',
                value: model?.contactEmail,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Mobile number',
                value: "${model?.contactCountryCode} ${model?.contactPhone}",
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ProfileLabeledBlock(
                      label: 'Date of birth',
                      value: AppDateFormat.formatDob( model?.dateOfBirth ?? ''),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ProfileLabeledBlock(label: 'Gender', value: model?.gender),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Website',
                value: model?.websiteLink,
              ),
            ],
          ),
        ),
        if (model?.drivingLicenseFront != null)...[
          const SizedBox(height: 32),
             ProfileSectionHeader(
              icon: Image.asset(AppAssetPaths.divingLicenseIcon),
              title: 'Driving License',
            ),
            const SizedBox(height: 16),
             ProfileDocumentPair(
              frontImage: 
              AppCachedNetworkImage(imageUrl: model?.drivingLicenseFront, boxFit: BoxFit.cover,),
              backImage: AppCachedNetworkImage(imageUrl: model?.drivingLicenseBack, boxFit: BoxFit.cover,),
            )
            ],
             if (model?.idDocumentFront != null)...[
            const SizedBox(height: 32),
             ProfileSectionHeader(
              icon: Image.asset(AppAssetPaths.divingLicenseIcon),
              title: 'ID Document',
            ),
            const SizedBox(height: 12),
             ProfileDocumentPair(
              frontImage: AppCachedNetworkImage(imageUrl: model?.idDocumentFront, boxFit: BoxFit.cover,),
              backImage: AppCachedNetworkImage(imageUrl: model?.idDocumentBack, boxFit: BoxFit.cover,),
              )
             ],
            const SizedBox(height: 32),
            ProfileInfoCard(
              child: Column(
                children: [
                    const ProfileSectionHeader(
              icon: Icon(
            Icons.location_on_outlined,
            size: 22,
            color: AppColors.primaryColor,
          ) ,
              title: 'Business Address',
            ),
          const SizedBox(height: 24,),
           model?.businessAddress != null ?
                  _companyAddressTile(
                    context,
                    fullAddress: AddressFormatter.formatBusinessAddress(
                      address: model?.businessAddress,
                      street: model?.businessStreet,
                      houseNumber: model?.businessHouseNumber,
                      postalCode: model?.businessPostalCode,
                      city: model?.businessCity,
                    ),
                  ): EmptyWidget(),
                ],
              ),
            ),
            const SizedBox(height:29),
            ProfileInfoCard(
              child: Column(
                children: [
                  const ProfileSectionHeader(
              icon: Icon(
            Icons.account_balance_wallet_outlined,
            size: 22,
            color: AppColors.primaryColor,
          ) ,
              title: 'Billing Address',
            ),
            const SizedBox(height: 24),
              model?.billingAddress != null ?
                  _companyAddressTile(
                    context,
                    fullAddress: AddressFormatter.formatBillingAddress(
                      address: model?.billingAddress,
                      street: model?.billingStreet,
                      houseNumber: model?.billingHouseNumber,
                      postalCode: model?.billingPostalCode,
                      city: model?.billingCity,
                    ),
                  )
                  : EmptyWidget(),
                ],
              ),
            ),

      ],
    );
  }

  Widget _companyAddressTile(
    BuildContext context, {
    // required String country,
    // String? address,
    String? fullAddress
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrayColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fullAddress ?? '', style: context.titleMedium.copyWith(
            fontSize: 14, fontWeight: FontWeight.w700
          ),),
          // Text(fullAddress ?? '',
          // style: context.labelMedium.copyWith(
          //   color: Color(0xff7F7F7F),
          //   fontSize: 14
          // ),
          // ),
          const SizedBox(height: 6),
          // Text(
          //   country,
          //   style: context.bodyLarge.copyWith(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w700,
          //     color: AppColors.primaryColor,
          //   ),
          // ),
        ],
      ),
    );
  }



}
