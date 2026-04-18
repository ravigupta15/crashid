import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_document_pair_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_info_card_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_labeled_block_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_section_header_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  static void open(BuildContext context) {
    context.push(AppRoutesPath.profileScreen);
  }

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "My Profile"),
      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    return ColoredBox(
      color: AppColors.screenBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileHeader(
              initials: 'R',
              displayName: 'Roman Henderson',
              onEdit: () {},
            ),
            const SizedBox(height: 50),
            const ProfileSectionHeader(
              icon: Icons.person_outline_rounded,
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
              icon: Icons.description_outlined,
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
            const ProfileSectionHeader(
              icon: Icons.credit_card_outlined,
              title: 'Driving License',
            ),
            const SizedBox(height: 16),
            const ProfileDocumentPair(
              assetPath: "assets/images/License Back.png",
            ),
            const SizedBox(height: 32),
            const ProfileSectionHeader(
              icon: Icons.perm_identity_rounded,
              title: 'ID Document',
            ),
            const SizedBox(height: 12),
            const ProfileDocumentPair(
              assetPath: "assets/images/License Back.png",),
          ],
        ),
      ),
    );
  }
}
