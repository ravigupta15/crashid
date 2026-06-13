import 'package:crashid/features/profile/presentation/widgets/profile_document_pair_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_info_card_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_labeled_block_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_section_header_widget.dart';
import 'package:crashid/features/profile/model/profile_response_model.dart';
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
    return _screenContent();
  }

  Widget _screenContent() {
  
    return Column(
      children: [
         const ProfileSectionHeader(
              icon: Icon(
            Icons.person_outline_rounded,
            size: 22,
            color: AppColors.primaryColor,
          ) ,
              title: 'Personal Details',
            ),
            const SizedBox(height: 12),
            ProfileInfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileLabeledBlock(
                    label: 'Full name',
                    value: "${profileData?.firstName} ${profileData?.lastName}",
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ProfileLabeledBlock(
                          label: 'Date of birth',
                          value: AppDateFormat.formatDob(profileData?.dateOfBirth ?? ''),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ProfileLabeledBlock(
                          label: 'Gender',
                          value: profileData?.gender,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const ProfileSectionHeader(
              icon: Icon(
            Icons.description_outlined,
            size: 22,
            color: AppColors.primaryColor,
          ) ,
              title: 'Contact Info',
            ),
            const SizedBox(height: 16),
            ProfileInfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileLabeledBlock(
                    label: 'Phone number',
                    value: "${profileData?.countryCode ?? ''} ${profileData?.mobileNumber ?? ''}",
                  ),
                  const SizedBox(height: 29),
                  ProfileLabeledBlock(
                    label: 'Email address',
                    value: profileData?.email,
                  ),
                  const SizedBox(height: 29),
                  ProfileLabeledBlock(
                    label: 'Residential address',
                    value: profileData?.address,
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
             ProfileDocumentPair(
             frontImage:  AppCachedNetworkImage(imageUrl: profileData?.drivingLicenseFront ?? '', boxFit: BoxFit.cover,canOpenImage: true,),
              backImage: AppCachedNetworkImage(imageUrl: profileData?.drivingLicenseBack ?? '', boxFit: BoxFit.cover,canOpenImage: true,),
            
            ),
            const SizedBox(height: 32),
             ProfileSectionHeader(
              icon: Image.asset(AppAssetPaths.divingLicenseIcon),
              title: 'ID Document',
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