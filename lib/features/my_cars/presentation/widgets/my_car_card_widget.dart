import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/my_cars/model/my_car_response_model.dart';
import 'package:crashid/features/my_cars/presentation/widgets/car_detail_info_row_widget.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_cached_network/app_cached_network_images.dart';
import 'package:flutter/material.dart';

class MyCarCardWidget extends StatelessWidget {
  final CarData? model;
  final VoidCallback? onTap;
  final VoidCallback? onDeleteTap;

  const MyCarCardWidget({super.key, this.model, this.onTap, this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.lightGrayColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.02),
              blurRadius: 20,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: AppCachedNetworkImage(
                imageUrl: model?.primaryImageUrl ?? '',
                height: 180,
                boxFit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 19),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      model?.carName ?? '',
                      style: context.titleMedium.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkGrayColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: onDeleteTap,
                    child: Image.asset(
                      AppAssetPaths.deleteIcon,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                height: 40,
                padding: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.blackColor),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 20,
                      color: AppColors.blackColor.withValues(alpha: .2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          bottomLeft: Radius.circular(3),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssetPaths.roundStrokeIcon),
                          const SizedBox(height: 5),
                          Text(
                            "D",
                            style: context.bodyMedium.copyWith(
                              fontSize: 10,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      model?.plateNumber ?? '',
                      style: context.titleMedium.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CarDetailInfoRow(label: AppLocalizations.of(context)!.fuelType, value: model?.fuelType ?? ''),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(AppAssetPaths.horizontalLineImg),
            ),
            CarDetailInfoRow(
              label: AppLocalizations.of(context)!.insuranceNumber,
              value: model?.insuranceNumber ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
