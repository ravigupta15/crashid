import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class CompanyLegalPdfInfoWidget extends StatelessWidget {
  final String? date;
  final VoidCallback? onClick;
  const CompanyLegalPdfInfoWidget({super.key, this.date, this.onClick});

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
                  AppLocalizations.of(context)!.legalFormPdf,
                  style: context.bodyLarge.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGrayColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  AppLocalizations.of(context)!.lastUpdated(date ?? ''),
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
