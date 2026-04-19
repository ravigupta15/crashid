import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:crashid/features/profile/presentation/widgets/company_account_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  static const kIsAppbarHide = "/kIsAppbarHide";

  final bool? isAppBarHide;

  static void open(BuildContext context, {
    bool? isAppBarHide
  }) {
    context.push(AppRoutesPath.profileScreen, extra: {
      kIsAppbarHide: isAppBarHide
    });
  }

  const ProfileScreen({super.key, this.isAppBarHide});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.isAppBarHide ?? false) ? null : const CustomAppBar(title:
       "My Profile"),
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
              onEdit: _openEditProfileScreen,
            ),
            const SizedBox(height: 50),
            CompanyAccountWidget(),
          ],
        ),
      ),
    );
  }

    // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

void _openEditProfileScreen(){
  EditProfileScreen.open(context);
}
}
