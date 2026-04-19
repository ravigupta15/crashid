import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:crashid/features/auth/registration/presentation/pages/choose_account_type_screen.dart';
import 'package:crashid/features/auth/signin/model/sign_in_model.dart';
import 'package:crashid/features/auth/signin/provider/singin_notifier.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_checkbox/app_checkbox_widget.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/extensions/extension_navigator.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/validators/app_validation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SigninScreen extends ConsumerStatefulWidget {
  static void open(BuildContext context) {
    context.push(AppRoutesPath.signinScreen);
  }

  static void openRemove(BuildContext context) {
    context.pushNamedAndRemoveUntil(AppRoutesPath.signinScreen);
  }

  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> with AppValidation {
  final _formKey = GlobalKey<FormState>();

  SignInSendModel? sendModel;

  @override
  void initState() {
    super.initState();
    sendModel = SignInSendModel();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signinNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          showFeedbackMessage(
            error.toString(),
            context: context,
            feedbackStyle: FeedbackStyle.snackBar,
            snackBarBgColor: AppColors.redColor,
          );
        },
      );
    });
    return Scaffold(body: _screenContent());
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 40,
            bottom: 30,
          ),
          child: Column(
            children: [
              Text(
                "Sign In",
                style: context.titleLarge.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 41),
              Image.asset(AppAssetPaths.appLogoIcon, height: 100),
              const SizedBox(height: 70),
              AppTextFormField(
                hintText: "Email Address",
                prefixIcon: Image.asset(
                  AppAssetPaths.mailIcon,
                  height: 12,
                  width: 16,
                ),
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                initialValue: sendModel?.email,
                validator: validateEmail,
                onSaved: _savedEmail,
              ),
              const SizedBox(height: 29),
              AppTextFormField(
                hintText: "Password",
                obscure: (sendModel?.password ?? '').isEmpty ? false : true,
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
              const SizedBox(height: 10),
              Row(
                children: [
                  AppCheckbox(
                    label: "terms & conditions and the privacy policy.",
                    activeColor: AppColors.primaryColor,
                    labelStyle: context.labelMedium.copyWith(
                      fontSize: 9,
                      color: AppColors.darkGrayColor.withValues(alpha: .6),
                      fontWeight: FontWeight.w500,
                    ),
                    value: sendModel?.acceptTerms ?? false,
                    onChanged: _onChangedCheckbox,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: _openForgetPasswordScreen,
                    child: Text(
                      "Forget Password",
                      style: context.titleMedium.copyWith(
                        fontSize: 10,
                        color: AppColors.darkGrayColor.withValues(alpha: .6),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 33),
              AppElevatedButton.withTitle(
                title: "Sign In",
                onPressed: _submitSignIn,
              ),
              const SizedBox(height: 20),
              _cotinueWithWidget(),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialWidget(img: AppAssetPaths.googleIcon),
                  const SizedBox(width: 18),
                  _socialWidget(img: AppAssetPaths.appleIcon),
                  const SizedBox(width: 18),
                  _socialWidget(img: AppAssetPaths.facebookIcon),
                ],
              ),
              const SizedBox(height: 20),
              _signUpWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cotinueWithWidget() {
    return Row(
      children: [
        Expanded(child: Image.asset(AppAssetPaths.vector1Icon)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            "or continue with",
            style: context.bodyMedium.copyWith(
              fontSize: 11,
              color: AppColors.darkGrayColor.withValues(alpha: .6),
            ),
          ),
        ),
        Expanded(child: Image.asset(AppAssetPaths.vector2Icon)),
      ],
    );
  }

  Widget _socialWidget({String? img, VoidCallback? onTap}) {
    return InkWell(onTap: onTap, child: Image.asset(img ?? '', height: 42));
  }

  Widget _signUpWidget() {
    return Column(
      children: [
        Container(
          width: 52,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColors.primaryColor),
          ),
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            text: "Don’t have an account?",
            style: context.bodyMedium.copyWith(
              fontSize: 12,
              color: AppColors.darkGrayColor,
            ),
            children: [
              TextSpan(
                text: " Sign Up",
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _openChooseAccountTypeScreen(),
                style: context.titleMedium.copyWith(
                  fontSize: 12,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

  void _onChangedCheckbox(bool val) {
    setState(() {
      sendModel?.acceptTerms = val;
    });
  }

  void _savedEmail(String? value) {
    sendModel?.email = value?.trim();
  }

  void _savedPassword(String? value) {
    sendModel?.password = value;
  }

  Future<void> _submitSignIn() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    if (!(sendModel?.acceptTerms ?? false)) {
      showFeedbackMessage(
        'Please accept the terms & conditions and the privacy policy.',
        context: context,
        feedbackStyle: FeedbackStyle.snackBar,
        snackBarBgColor: AppColors.redColor,
      );
      return;
    }
    final model = sendModel;
    if (model == null) return;
    await ref.read(signinNotifierProvider.notifier).login(context, model);
  }

  void _openForgetPasswordScreen() {
    ForgetPasswordScreen.open(context);
  }

  void _openChooseAccountTypeScreen() {
    ChooseAccountTypeScreen.open(context);
  }

}
