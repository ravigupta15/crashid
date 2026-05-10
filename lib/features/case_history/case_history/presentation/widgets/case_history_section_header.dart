import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

/// Section title with optional badge (e.g. "1 Active").
class CaseHistorySectionHeader extends StatelessWidget {
  const CaseHistorySectionHeader({
    super.key,
    required this.title,
    this.badgeLabel,
  });

  final String title;
  final String? badgeLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: context.titleMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
            ),
          ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.aliceBlueColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              child: Text(
                badgeLabel!,
                style: context.bodySmall.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
