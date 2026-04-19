import 'package:crashid/features/profile/presentation/widgets/profile_document_pair_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_info_card_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_labeled_block_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_section_header_widget.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class PersonalAccountWidget extends StatelessWidget {
  const PersonalAccountWidget({super.key});

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
                  const ProfileLabeledBlock(
                    label: 'Full name',
                    value: 'Roman Richard Henderson',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ProfileLabeledBlock(
                          label: 'Date of birth',
                          value: 'March 12, 1985',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ProfileLabeledBlock(
                          label: 'Gender',
                          value: 'Male',
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileLabeledBlock(
                    label: 'Phone number',
                    value: '+41 (555) 234-8901',
                  ),
                  SizedBox(height: 29),
                  ProfileLabeledBlock(
                    label: 'Email address',
                    value: 'romanrichardhenderson@gmai.com',
                  ),
                  SizedBox(height: 29),
                  ProfileLabeledBlock(
                    label: 'Residential address',
                    value:
                        '782 Oakwood Avenue, Suite 400, Chicago, 60605',
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
           
      ],
    );
  }
}