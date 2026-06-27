import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/auth/otp/model/otp_send_model.dart';
import 'package:crashid/features/auth/otp/provider/otp_notifier.dart';
import 'package:crashid/features/auth/otp/provider/otp_state.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends ConsumerStatefulWidget {
  static const  kId = 'kId';
  static const kType = 'kType';
  static const kEmail = 'kEmail';

  final String? id;
  final String? type;
  final String? email;
  static void open(BuildContext context, {
    String? id,
    String? type,
    String? email,
  }) {
    context.push(AppRoutesPath.otpScreen, extra: {
      kId: id,
      kType: type,
      kEmail: email,
    });
  }

  const OtpScreen({super.key, this.id, this.type, this.email});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final TapGestureRecognizer _resendOtpRecognizer = TapGestureRecognizer();

  final _formKey = GlobalKey<FormState>();

  OtpSendModel? sendModel;

  final otpProvider =
      AsyncNotifierProvider<OtpNotifier, OtpState>(
        OtpNotifier.new,
      );

  @override
  void initState() {
    super.initState();
    sendModel = OtpSendModel(
      id: widget.id,
      type: widget.type,
    );
    _resendOtpRecognizer.onTap = _resendOtp;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomWidget(),
      body: _screenContent(context),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 40,
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.enterOtp,
                style: context.titleLarge.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Image.asset(AppAssetPaths.otpImg, height: 190),
              const SizedBox(height: 32),
              Text(
                AppLocalizations.of(context)!.otpSentMessageTitle,
                textAlign: TextAlign.center,
                style: context.bodyMedium.copyWith(
                  fontSize: 12,
                  color: AppColors.darkGrayColor.withValues(alpha: .6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.email ?? '',
                style: context.titleMedium.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 40),
              _otpTextField(context),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppElevatedButton.withTitle(
            title: AppLocalizations.of(context)!.continueTitle,
            onPressed: _validateOtp,
          ),
          const SizedBox(height: 30),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: context.titleMedium.copyWith(
                fontSize: 14,
                color: AppColors.darkGrayColor.withValues(alpha: .7),
              ),
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.didntGetOtp,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.darkGrayColor,
                  ),
                ),
                TextSpan(
                  text: AppLocalizations.of(context)!.resendOtp,
                  style: context.titleMedium.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryColor,
                  ),
                  recognizer: _resendOtpRecognizer,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _otpTextField(BuildContext context) {
    return PinCodeTextField(
      controller: _otpController,
      autovalidateMode: AutovalidateMode.disabled,
      cursorHeight: 20,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.circle,
        borderRadius: BorderRadius.circular(8),
        activeColor: const Color(0xffF2F3F4),
        disabledColor: const Color(0xffF2F3F4),
        selectedColor: const Color(0xffF2F3F4),
        inactiveColor: const Color(0xffF2F3F4),
        fieldHeight: 45,
        fieldWidth: 45,
        inactiveFillColor: const Color(0xffF2F3F4),
        selectedFillColor: const Color(0xffF2F3F4),
        activeFillColor: const Color(0xffF2F3F4),
      ),
      cursorColor: AppColors.primaryColor,
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      length: 6,
      animationDuration: const Duration(milliseconds: 300),
      appContext: context,
      keyboardType: TextInputType.number,
      textStyle: const TextStyle(color: AppColors.blackColor),
      enableActiveFill: true,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return AppLocalizations.of(context)!.required;
        }
        if (val.length < 6) {
          return AppLocalizations.of(context)!.invalidOtp;
        }
        return null;
      },
    );
  }

  // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

  void _validateOtp() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    sendModel?.otp = _otpController.text;
    _callVerifyOtpApi();
  }

  void _resendOtp() {
    setState(() {
      sendModel?.otp = null;
      _otpController.clear();
    });
    _callResendOtpApi();
  }


  void _callVerifyOtpApi() async {
    await ref
        .read(otpProvider.notifier)
        .verifyOtp(context, model: sendModel);
  }

  void _callResendOtpApi() async {
    await ref
        .read(otpProvider.notifier)
        .resendOtp(context, model: sendModel);
  }
}
