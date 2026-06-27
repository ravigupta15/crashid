import 'package:crashid/features/profile/presentation/widgets/profile_document_pair_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_info_card_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_labeled_block_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_section_header_widget.dart';
import 'package:crashid/features/profile/model/profile_response_model.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_cached_network/app_cached_network_images.dart';
import 'package:crashid/utils/date_format/app_date_format.dart';
import 'package:flutter/material.dart';

class PersonalAccountWidget extends StatelessWidget {
  final ProfileModel? profileData;

  const PersonalAccountWidget({super.key, this.profileData});

  @override
  Widget build(BuildContext context) {
    return _screenContent(context);
  }

  Widget _screenContent(BuildContext context) {
  
    return Column(
      children: [
         ProfileSectionHeader(
              icon: Icon(
            Icons.person_outline_rounded,
            size: 22,
            color: AppColors.primaryColor,
          ) ,
              title: AppLocalizations.of(context)!.profilePersonalDetails,
            ),
            const SizedBox(height: 12),
            ProfileInfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileLabeledBlock(
                    label: AppLocalizations.of(context)!.profileFullName,
                    value: "${profileData?.firstName ?? ''} ${profileData?.lastName ?? ''}",
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ProfileLabeledBlock(
                          label: AppLocalizations.of(context)!.dateOfBirth,
                          value: AppDateFormat.formatDob(profileData?.dateOfBirth ?? ''),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ProfileLabeledBlock(
                          label: AppLocalizations.of(context)!.profileGender,
                          value: profileData?.gender,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ProfileSectionHeader(
              icon: Icon(
            Icons.description_outlined,
            size: 22,
            color: AppColors.primaryColor,
          ) ,
              title: AppLocalizations.of(context)!.profileContactInfo,
            ),
            const SizedBox(height: 16),
            ProfileInfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileLabeledBlock(
                    label: AppLocalizations.of(context)!.profilePhoneNumber,
                    value: "${profileData?.countryCode ?? ''} ${profileData?.mobileNumber ?? ''}",
                  ),
                  const SizedBox(height: 29),
                  ProfileLabeledBlock(
                    label: AppLocalizations.of(context)!.emailAddress,
                    value: profileData?.email,
                  ),
                  const SizedBox(height: 29),
                  ProfileLabeledBlock(
                    label: AppLocalizations.of(context)!.profileResidentialAddress,
                    value: profileData?.address,
                  ),
                ],
              ),
            ),
             const SizedBox(height: 32),
             ProfileSectionHeader(
              icon: Image.asset(AppAssetPaths.divingLicenseIcon),
              title: AppLocalizations.of(context)!.profileDrivingLicense,
            ),
            const SizedBox(height: 16),
             ProfileDocumentPair(
             frontImage:  AppCachedNetworkImage(imageUrl: profileData?.drivingLicenseFront ?? '', boxFit: BoxFit.cover,canOpenImage: true,),
              backImage: AppCachedNetworkImage(imageUrl: profileData?.drivingLicenseBack ?? '', boxFit: BoxFit.cover,canOpenImage: true,),
            
            ),
            const SizedBox(height: 32),
             ProfileSectionHeader(
              icon: Image.asset(AppAssetPaths.divingLicenseIcon),
              title: AppLocalizations.of(context)!.profileIdDocument,
            ),
            const SizedBox(height: 12),
             ProfileDocumentPair(
              frontImage: AppCachedNetworkImage(imageUrl: profileData?.idDocumentFront ?? '', boxFit: BoxFit.cover,canOpenImage: true,),
              backImage: AppCachedNetworkImage(imageUrl: profileData?.idDocumentBack ?? '', boxFit: BoxFit.cover,canOpenImage: true,),
            ),
           
      ],
    );
  }

}
