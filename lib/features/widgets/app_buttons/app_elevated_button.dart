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
  final Color? borderColor;
  final double? borderRadius;

  const AppElevatedButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.color,
      this.padding,
      this.shape,
      this.width,
      this.borderColor,
      this.borderRadius});

  factory AppElevatedButton.withTitle({
    Key? key,
    VoidCallback? onPressed,
    EdgeInsets? padding,
    Color? textColor,
    Color? color,
    required String title,
    double? width,
    Color? borderColor,
    double? fontSize,
    double? borderRadius,
    FontWeight? fontWeight,
  }) {
    return AppElevatedButton(
      key: key,
      padding: padding,
      color: color,
      width: width,
      borderColor: borderColor,
      borderRadius: borderRadius,
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
    required Widget icon,
    required String title,
  }) {
    return AppElevatedButton(
        key: key,
        onPressed: onPressed,
        padding: padding,
        color: color ,
        width: width,
        borderRadius: borderRadius,
        label: labelIconWidget(title, icon, textColor ?? AppColors.accentColor, iconFirst,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 180,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 40),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: .2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ]
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
