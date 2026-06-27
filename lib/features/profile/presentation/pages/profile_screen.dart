import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/data_sources/local_storage/secure_storage.dart';
import 'package:crashid/features/profile/model/profile_response_model.dart';
import 'package:crashid/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:crashid/features/profile/presentation/widgets/company_account_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/personal_account_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:crashid/features/profile/provider/profile_notifier.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
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
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
 

@override
  void initState() {
    _callProfileApi();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.isAppBarHide ?? false) ? null : CustomAppBar(title:
       AppLocalizations.of(context)!.drawerMyProfile),
      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    final refState = ref.watch(profileNotifier);
    var model = refState.value?.profileResponseModel?.data;
    final String fullName =
        '${(model?.firstName ?? model?.legalCompanyName ?? '').toString().trim()} ${(model?.lastName ?? '').toString().trim()}'
            .trim();
    final String initials = _buildInitials(fullName);

    return ColoredBox(
      color: AppColors.screenBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileHeader(
              initials: initials,
              displayName: fullName.isNotEmpty ? fullName : '',
              onEdit: () => _openEditProfileScreen( model),
            ),
            const SizedBox(height: 50),
            model?.accountType == "personal" ?
             PersonalAccountWidget(profileData: model) :
            CompanyAccountWidget(profileData: model),
          ],
        ),
      ),
    );
  }

    // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

void _openEditProfileScreen(ProfileModel? model) {
  EditProfileScreen.open(context, model: model).then((val) {
      _callProfileApi();
  });
}

void _callProfileApi() async{
    await ref
        .read(profileNotifier.notifier)
        .getProfile(context);
  }

String _buildInitials(String fullName) {
  if (fullName.trim().isEmpty) return '';
  final parts = fullName.trim().split(RegExp(r'\s+'));
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
}


}
