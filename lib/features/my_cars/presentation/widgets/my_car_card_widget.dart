import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/my_cars/presentation/widgets/car_detail_info_row_widget.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class MyCarCardWidget extends StatelessWidget {
  final String carName;
  final String licensePlate;
  final String fuelType;
  final String insuranceNumber;

  const MyCarCardWidget({
    super.key,
    required this.carName,
    required this.licensePlate,
    required this.fuelType,
    required this.insuranceNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: SizedBox(
              height: 180,
              child: Image.asset(
                AppAssetPaths.dummyCarImg,
                fit: BoxFit.cover,
              ),
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
                    carName,
                    style: context.titleMedium.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkGrayColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.more_horiz, color: AppColors.darkGrayColor),
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
                    licensePlate,
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
          CarDetailInfoRow(label: 'Fuel Type', value: fuelType),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset(AppAssetPaths.horizontalLineImg),
          ),
          CarDetailInfoRow(label: 'Insurance Number', value: insuranceNumber),
        ],
      ),
    );
  }
}
