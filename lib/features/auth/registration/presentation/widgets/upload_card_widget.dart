import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class UploadCardWidget extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  const UploadCardWidget({super.key, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: context.bodyMedium.copyWith(
              color: AppColors.darkGrayColor.withValues(alpha: .6),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 92,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: AppColors.lightGrayColor),
              ),
              child: Center(
                child: Image.asset(
                  AppAssetPaths.uploadIcon,
                  height: 38,
                  width: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}