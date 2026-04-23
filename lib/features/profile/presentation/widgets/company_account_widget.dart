import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/profile/model/profile_response_model.dart';
import 'package:crashid/features/profile/presentation/widgets/company_legal_pdf_info_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_document_pair_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_info_card_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_labeled_block_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_section_header_widget.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/date_format/app_date_format.dart';
import 'package:flutter/material.dart';

class CompanyAccountWidget extends StatefulWidget {
  final Data? profileData;

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
                value: widget.profileData?.legalCompanyName,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Registered name',
                value: widget.profileData?.registeredCompanyName,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'VAT ID',
                value: widget.profileData?.vatId,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Comm. reg. number',
                value: widget.profileData?.commercialRegistrationNumber,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Company email',
                value: widget.profileData?.generalEmail,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Company phone number',
                value: "${widget.profileData?.countryCode ?? ''} ${widget.profileData?.companyPhone ?? ''}",
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(label: 'Industry', value: widget.profileData?.industry),
              const SizedBox(height: 20),
              CompanyLegalPdfInfoWidget(),
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
                value: widget.profileData?.contactFirstName,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Job title',
                value: widget.profileData?.jobTitle,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Email address',
                value: widget.profileData?.email,
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Mobile number',
                value: widget.profileData?.mobileNumber,
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ProfileLabeledBlock(
                      label: 'Date of birth',
                      value: AppDateFormat.formatDob( widget.profileData?.dateOfBirth ?? ''),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ProfileLabeledBlock(label: 'Gender', value: widget.profileData?.gender),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ProfileLabeledBlock(
                label: 'Website',
                value: widget.profileData?.websiteLink,
              ),
            ],
          ),
        ),
          const SizedBox(height: 32),
             ProfileSectionHeader(
              icon: Image.asset(AppAssetPaths.divingLicenseIcon),
              title: 'Driving License',
            ),
            const SizedBox(height: 16),
            const ProfileDocumentPair(
              assetPath: "assets/images/License Back.png",
            ),
            const SizedBox(height: 32),
             ProfileSectionHeader(
              icon: Image.asset(AppAssetPaths.divingLicenseIcon),
              title: 'ID Document',
            ),
            const SizedBox(height: 12),
            const ProfileDocumentPair(
              assetPath: "assets/images/License Back.png",),
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
                  _companyAddressTile(
                    context,
                    country: 'Germany',
                  ),
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
            
                  _companyAddressTile(
                    context,
                    country: 'Germany',
                  ),
                ],
              ),
            ),

      ],
    );
  }

  Widget _companyAddressTile(
    BuildContext context, {
    required String country,
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
          Text("Hauptstraße 142", style: context.titleMedium.copyWith(
            fontSize: 14, fontWeight: FontWeight.w700
          ),),
          Text("Building B, Floor 4\n10115 Berlin",
          style: context.labelMedium.copyWith(
            color: Color(0xff7F7F7F),
            fontSize: 14
          ),
          ),
          const SizedBox(height: 6),
          Text(
            country,
            style: context.bodyLarge.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

}
