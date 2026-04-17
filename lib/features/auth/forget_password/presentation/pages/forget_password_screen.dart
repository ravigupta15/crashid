import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/auth/forget_password/presentation/pages/otp_screen.dart';
import 'package:crashid/features/auth/forget_password/presentation/widgets/check_email_widget.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordScreen extends StatefulWidget {
  
  static void open(BuildContext context) {
    context.push(AppRoutesPath.forgetPassword);
  }
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------
 

 Widget _screenContent() {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 30),
      child: Column(
        children: [
          Text("Forget Password ", 
          style: context.titleLarge.copyWith(
            fontSize: 20, fontWeight: FontWeight.w600
          ), ),
          const SizedBox(height: 41,),
          Image.asset(AppAssetPaths.appLogoIcon, height: 118,),
          const SizedBox(height: 90,),  
          AppTextFormField(
            prefixIcon: Image.asset(AppAssetPaths.mailIcon, height: 12,width: 16,),
            hintText: 'Email Address',
          ),
          const Spacer(),
          AppElevatedButton.withTitle(title: AppLocalizations.of(context)!.getStarted, onPressed: _openDialogBox)
        ],
      ),
    ),
  );
 }

 
  // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

  void _openDialogBox() {
    AppDialogBox().openBox(
      maxWidthMinWidth: MediaQuery.of(context).size.width * .8,
      screenContent: CheckEmailWidget(
        onTap: _openOtpScreen,
      )
    );
  }

  void _openOtpScreen() {
    OtpScreen.open(context);
  }
 

}