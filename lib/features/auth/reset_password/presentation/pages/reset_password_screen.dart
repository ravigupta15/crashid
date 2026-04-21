import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/auth/forget_password/provider/forget_password_notifier.dart';
import 'package:crashid/features/auth/forget_password/provider/forget_password_state.dart';
import 'package:crashid/features/auth/reset_password/model/reset_password_send_model.dart';
import 'package:crashid/features/auth/reset_password/presentation/widgets/password_change_confirmation_widget.dart';
import 'package:crashid/features/auth/reset_password/provider/reset_password_notifier.dart';
import 'package:crashid/features/auth/reset_password/provider/reset_password_state.dart';
import 'package:crashid/features/auth/signin/presentation/pages/signin_screen.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:crashid/utils/validators/app_validation.dart';
import 'package:crashid/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class ResetPasswordScreen extends ConsumerStatefulWidget {
 
 
 static void open(BuildContext context) {
    context.push(AppRoutesPath.resetPasswordScreen);
  }
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> with AppValidation {


final forgetPasswordProvider =
    AsyncNotifierProvider<ResetPasswordNotifier, ResetPasswordState>(ResetPasswordNotifier.new);


  final _formKey = GlobalKey<FormState>();
  ResetPasswordSendModel? sendModel;

  @override
  void initState() {
    super.initState();
    sendModel = ResetPasswordSendModel();
  }

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
              onPressed: _submitResetPassword,
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
    child: Form(
      key: _formKey,
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
              obscure: (sendModel?.password ?? '').isEmpty ? false : true,
               inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
               
              hintText: AppLocalizations.of(context)!.newPassword, 
               prefixIcon: Image.asset(
                  AppAssetPaths.lockIcon,
                  height: 20,
                  width: 16,
                ),
                textInputAction: TextInputAction.done,
                initialValue: sendModel?.password,
                validator: validatePassword,
                onChanged: _savedPassword,
              
            ),
            const SizedBox(height: 44,),
            AppTextFormField(
               obscure: (sendModel?.confirmPassword ?? '').isEmpty ? false : true,
               inputFormatters: [
                    Validator.emojiRestrict(),
                    Validator.removeWhiteSpace(),
                  ],
             
              hintText: AppLocalizations.of(context)!.confirmPassword,
                prefixIcon: Image.asset(
                  AppAssetPaths.lockIcon,
                  height: 20,
                  width: 16,
                ),
                textInputAction: TextInputAction.done,
                initialValue: sendModel?.password,
                validator: (val) => validateConfirmPassword(val, sendModel?.password),
                onChanged: _savedConfirmPassword,
              
            )
          ],
        ),
      ),
    ),
  );
}

  
  // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

void _savedPassword(String? value) {
    sendModel?.password = value;
    setState(() {
      
    });
  }
void _savedConfirmPassword(String? value) {
    sendModel?.confirmPassword = value;
    setState(() {
      
    });
  }

  Future<void> _submitResetPassword() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    _callResetPasswordApi();
  }

  
  void _callResetPasswordApi() async{
    await ref
        .read(forgetPasswordProvider.notifier)
        .resetPassword(context, model: sendModel);
  }

}

