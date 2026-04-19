import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileSectionHeader extends StatelessWidget {
  final Widget icon;
  final String title;

  const ProfileSectionHeader({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       icon,
        const SizedBox(width: 8),
        Text(
          title,
          style: context.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.darkGrayColor,
              ),
        ),
      ],
    );
  }
}
