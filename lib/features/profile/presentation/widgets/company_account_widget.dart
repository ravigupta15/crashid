import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/core/utils/address_formatter.dart';
import 'package:crashid/features/profile/model/profile_response_model.dart';
import 'package:crashid/features/profile/presentation/widgets/company_legal_pdf_info_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_document_pair_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_info_card_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_labeled_block_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_section_header_widget.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_cached_network/app_cached_network_images.dart';
import 'package:crashid/utils/date_format/app_date_format.dart';
import 'package:crashid/utils/empty/empty_widget.dart';
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
    return _screenContent(context);
  }

  Widget _screenContent(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final na = l10n.notAvailable;
    var model = widget.profileData;
    return Column(
      children: [
        ProfileSectionHeader(
          icon: Image.asset(AppAssetPaths.sericeGridIcon),
          title: l10n.profileCompanyInformation,
        ),
        const SizedBox(height: 12),
        ProfileInfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileLabeledBlock(
                label: l10n.profileLegalCompanyName,
                value: model?.legalCompanyName,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: l10n.profileRegisteredName,
                value: model?.registeredCompanyName,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: l10n.profileVatId,
                value: model?.vatId,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: l10n.profileCommercialRegNumber,
                value: model?.commercialRegistrationNumber,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: l10n.profileCompanyEmail,
                value: model?.generalEmail,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: l10n.companyPhoneNumber,
                value: "${model?.countryCode ?? ''} ${model?.companyPhone ?? ''}",
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(label: l10n.profileIndustry, value: model?.industry),
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
          title: l10n.profilePrimaryContactPerson,
        ),
        const SizedBox(height: 12),
        ProfileInfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileLabeledBlock(
                label: l10n.profileFullName,
                value: "${model?.contactFirstName ?? na} ${model?.contactLastName ?? ''}",
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: l10n.profileJobTitle,
                value: model?.jobTitle ?? na,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: l10n.emailAddress,
                value: model?.contactEmail ?? na,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: l10n.mobileNumber,
                value: "${model?.contactCountryCode ?? na} ${model?.contactPhone ?? ''}",
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ProfileLabeledBlock(
                      label: l10n.dateOfBirth,
                      value: model?.dateOfBirth != null ? AppDateFormat.formatDob(model?.dateOfBirth ?? '') : na,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ProfileLabeledBlock(label: l10n.profileGender, value: model?.gender),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: l10n.profileWebsite,
                value: model?.websiteLink,
              ),
            ],
          ),
        ),
        if (model?.drivingLicenseFront != null)...[
          const SizedBox(height: 32),
             ProfileSectionHeader(
              icon: Image.asset(AppAssetPaths.divingLicenseIcon),
              title: l10n.profileDrivingLicense,
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
              title: l10n.profileIdDocument,
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
                    ProfileSectionHeader(
              icon: Icon(
            Icons.location_on_outlined,
            size: 22,
            color: AppColors.primaryColor,
          ) ,
              title: l10n.profileBusinessAddress,
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
                  ProfileSectionHeader(
              icon: Icon(
            Icons.account_balance_wallet_outlined,
            size: 22,
            color: AppColors.primaryColor,
          ) ,
              title: l10n.profileBillingAddress,
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
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
