// import 'package:crashid/res/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:veezpay/res/app_colors.dart';
// import 'package:veezpay/res/app_font_family.dart';
// import 'package:veezpay/utils/extensions/extension_string.dart';
// // import 'package:vanlynk/utils/locale/app_localization_keys.dart';

// class LabelWithOptional extends StatelessWidget {
//   final String text;
//   final bool showOptional;
//   final String? iconPath;
//   final TextStyle? style;

//   const LabelWithOptional(
//       {super.key,
//       required this.text,
//       this.iconPath,
//       this.showOptional = false,
//       this.style});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         if (iconPath.isNotNullOrNotEmpty) ...[
//           // SvgPicture.asset(
//           //   iconPath!,
//           //   height: 12,
//           //   width: 12,
//           //   colorFilter: ColorFilter.mode(AppColors.iconTitle, BlendMode.srcIn),
//           // ),
//           SizedBox(width: 5),
//         ],
//         Text(
//           text,
//           style: style ??
//               TextStyle(
//                 fontSize: 14,
//                 color: AppColors.titleColor,
//                 fontFamily: AppFontFamily.medium,
//                 fontWeight: FontWeight.w500,
//               ),
//         ),
//         if (showOptional) ...[
//           SizedBox(width: 4),
//           Text(
//             '(Optional)',
//             style: TextStyle(
//               fontSize: 12,
//               fontFamily: AppFontFamily.medium,
//               fontWeight: FontWeight.w400,
//               color: AppColors.lightTextColor,
//               height: 0.14,
//             ),
//           ),
//         ]
//       ],
//     );
//   }
// }
