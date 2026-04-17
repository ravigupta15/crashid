import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/auth/reset_password/presentation/widgets/password_change_confirmation_widget.dart';
import 'package:crashid/features/auth/signin/presentation/pages/signin_screen.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class ResetPasswordScreen extends StatefulWidget {
 
 
 static void open(BuildContext context) {
    context.push(AppRoutesPath.resetPasswordScreen);
  }
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppElevatedButton.withTitle(
              title: AppLocalizations.of(context)!.resetPasswordButton,
              onPressed: _openDialogBox,
            )
          ],
        ),
      ),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Text(
              AppLocalizations.of(context)!.resetPasswordTitle,
              style: context.titleLarge.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          const SizedBox(height: 10,),
          Text(
            AppLocalizations.of(context)!.resetPasswordDescription,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(
            fontSize: 11, color: AppColors.darkGrayColor.withValues(alpha: .6),
            fontWeight: FontWeight.w700
          ),
          ),
          const SizedBox(height: 68,),
          AppTextFormField(
            obscure: true,
            hintText: AppLocalizations.of(context)!.newPassword,
          ),
          const SizedBox(height: 44,),
          AppTextFormField(
            obscure: true,
            hintText: AppLocalizations.of(context)!.confirmPassword,
          )
        ],
      ),
    ),
  );
}

void _openDialogBox() {
    AppDialogBox().openBox(
      maxWidthMinWidth: MediaQuery.of(context).size.width * .8,
      screenContent: PasswordChangeConfirmationWidget(
        onTap: _openSignInSCreen,
      )
    );
  }

  void _openSignInSCreen() {
    SigninScreen.openRemove(context);
  }
}

