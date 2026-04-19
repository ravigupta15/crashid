import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class CompanyLegalPdfInfoWidget extends StatelessWidget {
  const CompanyLegalPdfInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrayColor),
      ),
      child: Row(
        children: [
          Container(
            height: 40,width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.aliceBlueColor.withValues(alpha: .5)
            ),
            child: Image.asset(AppAssetPaths.pdfIcon, width: 36, height: 36,
            color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Legal Form PDF',
                  style: context.bodyLarge.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGrayColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Last updated: Oct 2023',
                  style: context.bodySmall.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.labelMedium,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.visibility_outlined,
            color: Color(0xff737686),
            size: 22,
          ),
        ],
      ),
         );
  }

  

}