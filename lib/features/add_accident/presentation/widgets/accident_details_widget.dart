import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class AccidentDetailsWidget extends StatelessWidget {
  const AccidentDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Accident Details",
          style: context.titleMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _accidentInfoCard(
                context: context,
                icon: AppAssetPaths.dateIcon,
                label: "Date",
                value: "Apr 24, 2024",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _accidentInfoCard(
                context: context,
                icon: AppAssetPaths.clockIcon,
                label: "Time",
                value: "9:41 AM",
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _accidentInfoCard(
          context: context,
          icon: AppAssetPaths.locationIcon,
          label: "Current Location",
          value: "123, Market Street, San Francisco, CA 94105",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Divider(
            color: AppColors.blackColor.withValues(alpha: .2),
          ),
        ),
      ],
    );
  }

    Widget _accidentInfoCard({
      required BuildContext context,
    required String icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightGrayColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(icon, ),
              const SizedBox(width: 6),
              Text(
                label,
                style: context.bodySmall.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff999999),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: context.titleMedium.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

}