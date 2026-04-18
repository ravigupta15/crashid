import 'package:crashid/features/widgets/app_buttons/common_widget.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget label;
  final Color? color;
  final EdgeInsets? padding;
  final OutlinedBorder? shape;
  final double? width;
  final double? height;
  final Color? borderColor;
  final double? borderRadius;
  final bool? isBoxShadow;

  const AppElevatedButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.color,
      this.padding,
      this.shape,
      this.width,
      this.height,
      this.borderColor,
      this.borderRadius,
      this.isBoxShadow = true});

  factory AppElevatedButton.withTitle({
    Key? key,
    VoidCallback? onPressed,
    EdgeInsets? padding,
    Color? textColor,
    Color? color,
    required String title,
    double? width,
    double? height,
    Color? borderColor,
    double? fontSize,
    double? borderRadius,
    FontWeight? fontWeight,
    bool? isBoxShadow = true
  }) {
    return AppElevatedButton(
      key: key,
      padding: padding,
      color: color,
      width: width,
      borderColor: borderColor,
      borderRadius: borderRadius,
      height: height,
      isBoxShadow: isBoxShadow,
      label: labelTextWidget(
        title,
        textColor ?? AppColors.accentColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      onPressed: onPressed,
    );
  }

  factory AppElevatedButton.withTitleAndIcon({
    Key? key,
    VoidCallback? onPressed,
    Color? color,
    Color? textColor,
    MainAxisAlignment? mainAxisAlignment,
    bool iconFirst = true,
    EdgeInsets? padding,
    double? borderRadius,
    double? width,
    double? height,
    bool? isBoxShadow = true,
    required Widget icon,
    required String title,
  }) {
    return AppElevatedButton(
        key: key,
        onPressed: onPressed,
        padding: padding,
        color: color ,
        width: width,
        height: height,
        isBoxShadow: isBoxShadow,
        borderRadius: borderRadius,
        label: labelIconWidget(title, icon, textColor ?? AppColors.accentColor, iconFirst,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 180,
      height: height ?? 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 40),
        boxShadow: (isBoxShadow ?? false) ? [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: .2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ] : []
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: padding ?? buttonPadding,
          shape: shape ?? buttonShape(borderRadius),
          backgroundColor: color ?? AppColors.primaryColor,
        ),
        onPressed: onPressed,
        child: label,
      ),
    );
  }
}
