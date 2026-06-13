import 'dart:io';

import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_cached_network/app_cached_network_images.dart';
import 'package:flutter/material.dart';

class UploadCardWidget extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  final File? hasFile;
  final String? imgUrl;
  const UploadCardWidget({
    super.key,
    this.title,
    this.onTap,
    this.hasFile,
    this.imgUrl
  });

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
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: hasFile != null
                      ? AppColors.primaryColor
                      : AppColors.lightGrayColor,
                ),
              ),
              child: Center(
                child: hasFile != null
                    ? ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(30),
                      child: Image.file(hasFile!, height: 92, width: double.infinity,
                       fit: BoxFit.cover))
                    : imgUrl != null ?
                    AppCachedNetworkImage(imageUrl: imgUrl ?? '', boxFit: BoxFit.cover,
                    borderRadius: 30,width: double.infinity, height: 92,)
                    :
                     Image.asset(
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