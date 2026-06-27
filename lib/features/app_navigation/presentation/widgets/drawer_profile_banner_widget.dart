import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_cached_network/app_cached_network_images.dart';
import 'package:flutter/material.dart';

class DrawerProfileBannerWidget extends StatelessWidget {
  final String? name;
  final String? profileImageUrl;
  final String? initials;
  const DrawerProfileBannerWidget({super.key, this.name, this.profileImageUrl, this.initials });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(152),
        bottomLeft: Radius.circular(152)
      )
      ),
      child: Row(
        children: [
          Container(
            width: 63,
            height: 63,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor,
            ),
            alignment: Alignment.center,
            child: profileImageUrl != null && profileImageUrl!.isNotEmpty ?
             AppCachedNetworkImage(imageUrl: profileImageUrl!, width: 63, height: 63, boxFit: BoxFit.cover, ) :
             Text(
              initials ?? '',
              style: context.displaySmall.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 34,
                height: 1,
              ),
            ),
          ),  
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.drawerWelcomeBack,
                  style: context.titleMedium.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name ?? '',
                  style: context.titleMedium.copyWith(
                    color: AppColors.accentColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
