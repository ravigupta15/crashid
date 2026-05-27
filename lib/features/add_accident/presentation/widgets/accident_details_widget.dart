import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

/// Displays accident date, time, and location. Values are supplied by the parent.
class AccidentDetailsWidget extends StatelessWidget {
  final bool? isAccidentTitle;
  final String dateValue;
  final String timeValue;
  final String locationValue;
  final VoidCallback? onDateTap;
  final VoidCallback? onTimeTap;
  final VoidCallback? onLocationTap;
  final bool? shouldShowLocation;

  const AccidentDetailsWidget({
    super.key,
    this.isAccidentTitle = true,
    required this.dateValue,
    required this.timeValue,
    required this.locationValue,
    this.onDateTap,
    this.onTimeTap,
    this.onLocationTap,
    this.shouldShowLocation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isAccidentTitle ?? false) ...[
          Text(
            "Accident Details",
            style: context.titleMedium.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 12),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onDateTap,
                child: _accidentInfoCard(
                  context: context,
                  icon: AppAssetPaths.dateIcon,
                  label: "Date",
                  value: dateValue,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: onTimeTap,
                child: _accidentInfoCard(
                  context: context,
                  icon: AppAssetPaths.clockIcon,
                  label: "Time",
                  value: timeValue,
                ),
              ),
            ),
          ],
        ),
        if (shouldShowLocation ?? true)...[
        const SizedBox(height: 12),
        _accidentInfoCard(
          context: context,
          icon: AppAssetPaths.locationIcon,
          label: "Current Location",
          value: locationValue,
          onTap: onLocationTap,
        ),
        ]
      ],
    );
  }

  Widget _accidentInfoCard({
    required BuildContext context,
    required String icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                Image.asset(icon),
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
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: context.titleMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
