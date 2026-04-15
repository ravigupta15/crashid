// import 'package:flutter/material.dart';
// import 'package:veezpay/features/widgets/app_buttons/common_widget.dart';
// import 'package:veezpay/res/app_colors.dart';

// class AppOutlinedButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final Widget child;
//   final Color? textColor;
//   final Color? borderColor;
//   final EdgeInsets? padding;
//   final double? borderRadius;
//   final Color? backgroundColor;
//   final double? width;

//   const AppOutlinedButton({
//     super.key,
//     required this.onPressed,
//     required this.child,
//     this.padding,
//     this.textColor,
//     this.borderColor,
//     this.borderRadius,
//     this.backgroundColor,
//     this.width,
//   });

//   factory AppOutlinedButton.withTitle(
//       {Key? key,
//       VoidCallback? onPressed,
//       EdgeInsets? padding,
//       Color textColor = AppColors.buttonOutlineTextColor,
//       required String title,
//       double? width,
//       Color? borderColor,
//       double? fontSize,
//       FontWeight? fontWeight,
//       Color? bgColor}) {
//     return AppOutlinedButton(
//       key: key,
//       padding: padding,
//       width: width,
//       borderColor: borderColor,
//       onPressed: onPressed,
//       backgroundColor: bgColor,
//       child: labelTextWidget(
//         title,
//         textColor,
//         fontSize: fontSize,
//         fontWeight: fontWeight,
//       ),
//     );
//   }

//   factory AppOutlinedButton.withTitleAndIcon({
//     Key? key,
//     VoidCallback? onPressed,
//     Color textColor = AppColors.buttonOutlineTextColor,
//     MainAxisAlignment? mainAxisAlignment,
//     Color? bgColor,
//     bool iconFirst = true,
//     EdgeInsets? padding,
//     required Widget icon,
//     required String title,
//   }) {
//     return AppOutlinedButton(
//         key: key,
//         onPressed: onPressed,
//         backgroundColor: bgColor,
//         padding: padding,
//         child: labelIconWidget(title, icon, textColor, iconFirst,
//             mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//         style: OutlinedButton.styleFrom(
//           backgroundColor: backgroundColor,
//           side: BorderSide(
//             color: borderColor ?? AppColors.buttonOutlineBorder,
//             width: 1,
//           ),
//           shape: buttonShape,
//           padding: padding ?? buttonPadding,
//         ),
//         onPressed: onPressed,
//         child: child);
//   }
// }
