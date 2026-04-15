// import 'package:flutter/material.dart';

// class AppTextButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final Widget child;

//   final EdgeInsets? padding;

//   const AppTextButton({
//     super.key,
//     required this.onPressed,
//     required this.child,
//     this.padding,
//   });

//   factory AppTextButton.withTitle({
//     Key? key,
//     VoidCallback? onPressed,
//     EdgeInsets? padding,
//     Color? textColor,
//     bool textWithUnderLine = false,
//     required String title,
//   }) {
//     return AppTextButton(
//       key: key,
//       onPressed: onPressed,
//       padding: padding,
//       child: labelTextWidget(title, textColor,
//           textWithUnderLine: textWithUnderLine),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//         style: TextButton.styleFrom(
//           padding: padding ?? buttonPadding,
//           shape: buttonShape,
//         ),
//         onPressed: onPressed,
//         child: child);
//   }
// }
