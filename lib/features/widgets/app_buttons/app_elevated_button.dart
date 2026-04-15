// import 'package:flutter/material.dart';

// class AppElevatedButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final Widget label;
//   final Color? color;
//   final EdgeInsets? padding;
//   final OutlinedBorder? shape;
//   final double? width;
//   final Color? borderColor;
//   final double? borderRadius;

//   const AppElevatedButton(
//       {super.key,
//       required this.onPressed,
//       required this.label,
//       this.color,
//       this.padding,
//       this.shape,
//       this.width,
//       this.borderColor,
//       this.borderRadius});

//   factory AppElevatedButton.withTitle({
//     Key? key,
//     VoidCallback? onPressed,
//     EdgeInsets? padding,
//     Color? textColor,
//     Color? color,
//     required String title,
//     double? width,
//     Color? borderColor,
//     double? fontSize,
//     FontWeight? fontWeight,
//   }) {
//     return AppElevatedButton(
//       key: key,
//       padding: padding,
//       color: color,
//       width: width,
//       borderColor: borderColor,
//       label: labelTextWidget(
//         title,
//         textColor ?? AppColors.whiteColor,
//         fontSize: fontSize,
//         fontWeight: fontWeight,
//       ),
//       onPressed: onPressed,
//     );
//   }

//   factory AppElevatedButton.withTitleAndIcon({
//     Key? key,
//     VoidCallback? onPressed,
//     Color? color,
//     Color? textColor,
//     MainAxisAlignment? mainAxisAlignment,
//     bool iconFirst = true,
//     EdgeInsets? padding,
//     required Widget icon,
//     required String title,
//   }) {
//     return AppElevatedButton(
//         key: key,
//         onPressed: onPressed,
//         padding: padding,
//         color: color,
//         label: labelIconWidget(title, icon, textColor, iconFirst,
//             mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         elevation: 0,
//         padding: padding ?? buttonPadding,
//         shape: shape ?? buttonShape,
//         backgroundColor: color ?? AppColors.colorPrimary,
//       ),
//       onPressed: onPressed,
//       child: label,
//     );
//   }
// }
