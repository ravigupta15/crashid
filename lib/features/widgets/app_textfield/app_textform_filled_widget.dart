import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class AppTextFormField extends StatefulWidget {
  final bool showOptional;
  final String? hintText;
  final String? helperText;
  final String? initialValue;
  final bool obscure;
  final bool enable;
  final void Function(String?)? onSaved;
  final void Function(String?)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final int maxLines;
  final int? maxLength;
  final String? customCounterText;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintTextStyle;
  Color? enableBorderColor;
  FocusNode? focusNode = FocusNode();
  Iterable<String>? autofillHints;
  final TextAlign? textAlign;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? errorWidget;
  final Color? formFieldFill;
  final GlobalKey<FormFieldState>? formFieldStateKey;
  final TextStyle? titleStyle;
  final bool isReadOnly;
  final Function()? onTap;
  final bool? isUnderlineBorder;
  final Color? textColor;
  final double? borderRadius;
  final double? prefixWidth;
  final TextCapitalization? textCapitalization;

  AppTextFormField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.onSaved,
    this.helperText,
    this.onChanged,
    this.hintTextStyle,
    this.initialValue,
    this.contentPadding,
    this.onFieldSubmitted,
    this.textInputAction,
    this.obscure = false,
    this.enable = true,
    this.maxLines = 1,
    this.maxLength,
    this.textInputType,
    this.validator,
    this.controller,
    this.inputFormatters,
    this.customCounterText,
    this.enableBorderColor,
    this.focusNode,
    this.autofillHints,
    this.textAlign = TextAlign.start,
    this.suffixIcon,
    this.showOptional = false,
    this.errorWidget,
    this.formFieldFill,
    this.formFieldStateKey,
    this.titleStyle,
    this.isReadOnly = false,
    this.onTap,
    this.isUnderlineBorder,
    this.textColor,
    this.borderRadius,
    this.prefixWidth,
    this.textCapitalization,
  }) : assert(initialValue == null || controller == null);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool obscure = true;
  bool setObscure = false;

  @override
  void initState() {
    super.initState();
    obscure = widget.obscure;
  }

  @override
  void didUpdateWidget(AppTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscure != oldWidget.obscure) {
      setState(() {
        obscure = widget.obscure;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          key: widget.formFieldStateKey,
          enabled: widget.enable,
          readOnly: widget.isReadOnly,
          onTap: widget.onTap,
          initialValue: widget.initialValue,
          obscureText: obscure,
          style: context.titleMedium.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: widget.textColor,
          ),
          textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
          controller: widget.controller,
          autofillHints: widget.autofillHints,
          inputFormatters: widget.inputFormatters,
          focusNode: widget.focusNode,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            errorMaxLines: 2,
            prefixIcon:widget.prefixIcon != null ? Container(
              width: widget.prefixWidth ??  40,
              margin: const EdgeInsets.only(right: 8),
              alignment: Alignment.centerRight,
              child: widget.prefixIcon,
            ) : null,
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            helperText: widget.helperText,
            counterText: widget.customCounterText,
            hintText: widget.hintText,
            fillColor: widget.formFieldFill ?? AppColors.whiteColor,
            filled: true,
            hintStyle:
                widget.hintTextStyle ??
                context.bodyMedium.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGrayColor.withValues(alpha: .6),
                ),
            enabledBorder: (widget.isUnderlineBorder ?? false)
                ? textFormFieldEnabledUnderlineBorder
                : textFormFieldEnabledBorder,
            disabledBorder: (widget.isUnderlineBorder ?? false)
                ? textFormFieldDisabledUnderlineBorder
                : textFormFieldDisabledBorder,
            errorBorder: (widget.isUnderlineBorder ?? false)
                ? textFormFieldErrorUnderlineBorder
                : textFormFieldErrorBorder,
            focusedErrorBorder: (widget.isUnderlineBorder ?? false)
                ? textFormFieldFocusErrorUnderlineBorder
                : textFormFieldFocusErrorBorder,
            focusedBorder: (widget.isUnderlineBorder ?? false)
                ? textFormFieldFocusUnderlineBorder
                : textFormFieldFocusBorder,
            border: const OutlineInputBorder(),
            error: widget.errorWidget,
            suffixIcon: widget.obscure
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: AppColors.darkGrayColor.withValues(alpha: .6),
                      ),
                    ),
                  )
                : widget.suffixIcon,
          ),
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          onSaved: widget.onSaved,
          validator: widget.validator,
          maxLines: widget.maxLines,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLength: widget.maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          textAlign: widget.textAlign!,
        ),
      ],
    );
  }

  OutlineInputBorder get textFormFieldErrorBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.borderRadius ?? 40),
    borderSide: BorderSide(color: AppColors.redColor),
  );

  OutlineInputBorder get textFormFieldFocusBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.borderRadius ?? 40),
    borderSide: BorderSide(color: AppColors.primaryColor),
  );

  OutlineInputBorder get textFormFieldFocusErrorBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.borderRadius ?? 40),
    borderSide: BorderSide(color: AppColors.redColor),
  );

  OutlineInputBorder get textFormFieldEnabledBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.borderRadius ?? 40),
    borderSide: BorderSide(
      color: widget.enableBorderColor ?? AppColors.lightGrayColor,
    ),
  );

  OutlineInputBorder get textFormFieldDisabledBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.borderRadius ?? 40),
    borderSide: BorderSide(
      color: widget.enableBorderColor ?? AppColors.lightGrayColor,
    ),
  );

  UnderlineInputBorder get textFormFieldErrorUnderlineBorder =>
      UnderlineInputBorder(
        borderSide: const BorderSide(color: AppColors.redColor),
      );

  UnderlineInputBorder get textFormFieldFocusUnderlineBorder =>
      UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      );

  UnderlineInputBorder get textFormFieldFocusErrorUnderlineBorder =>
      UnderlineInputBorder(
        borderSide: const BorderSide(color: AppColors.redColor),
      );

  UnderlineInputBorder get textFormFieldEnabledUnderlineBorder =>
      UnderlineInputBorder(
        borderSide: BorderSide(
          color: widget.enableBorderColor ?? AppColors.lightGrayColor,
        ),
      );

  UnderlineInputBorder get textFormFieldDisabledUnderlineBorder =>
      UnderlineInputBorder(
        borderSide: BorderSide(
          color: widget.enableBorderColor ?? AppColors.lightGrayColor,
        ),
      );
}
