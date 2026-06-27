import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/features/profile/model/profile_response_model.dart';
import 'package:crashid/features/profile/presentation/widgets/edit_company_profile_widget.dart';
import 'package:crashid/features/profile/presentation/widgets/edit_personal_profile_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatelessWidget {
  static const kModel = "/kModel";

  final ProfileModel? model;

  static Future<void> open(BuildContext context, { ProfileModel? model}) {
    return context.push(AppRoutesPath.editProfileScreen, extra: {
      kModel: model
    });
  }
  const EditProfileScreen({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.editProfileTitle,
      ),
      body: _screenContent(),
    );
  }

    // -----------------------------------------------------------------------------
Widget _screenContent() {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(left: 20, right: 20,top: 30, bottom: 40),
    child: model?.accountType == "personal" ? EditPersonalProfileWidget(
      profileData: model,
    ) : EditCompanyProfileWidget(
      profileData: model,
    )
    );
}
}
