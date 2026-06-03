import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_cached_network/app_cached_network_images.dart';
import 'package:crashid/utils/empty/empty_widget.dart';
import 'package:crashid/utils/extensions/extension_string.dart';
import 'package:flutter/material.dart';

class CaseDetailCardWidget extends StatelessWidget {
  final String accidentMetaLine;
  final String caseIdLine;
  final String address;
  final List<String> thumbnailAssets;
  final int overflowCount;
  final String statusLabel;
  final VoidCallback? onViewSummary;
  final String? clouserDate;

  static const double _thumbSize = 72;
  const CaseDetailCardWidget({
    super.key,
    required this.accidentMetaLine,
    required this.caseIdLine,
    required this.address,
    required this.thumbnailAssets,
    this.overflowCount = 0,
    required this.statusLabel,
    this.onViewSummary,
    this.clouserDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightGrayColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 35,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.aliceBlueColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.visibility_outlined,
                  color: AppColors.primaryColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      accidentMetaLine.toUpperCase(),
                      style: context.bodySmall.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                        color: Color(0xff434654),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      caseIdLine,
                      style: context.titleMedium.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.blackColor,
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if ((address).isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 34,
                  child: Icon(
                    Icons.location_on_outlined,
                    color: Color(0xff434654).withValues(alpha: .8),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    address,
                    style: context.bodySmall.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff434654).withValues(alpha: .8),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 9),
          _thumbnailRow(context),
          const SizedBox(height: 14),
          Divider(height: 1, color: AppColors.lightGrayColor),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      statusLabel.toString().replaceAll('_', ' ').toUpperCase(),
                      style: context.bodySmall.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff434654),
                      ),
                    ),
                    clouserDate.isNotNullOrNotEmpty
                        ? Text(
                            clouserDate.toString(),
                            style: context.bodyMedium.copyWith(
                              fontSize: 14,
                              color: AppColors.blackColor,
                            ),
                          )
                        : EmptyWidget(),
                  ],
                ),
              ),
              InkWell(
                onTap: onViewSummary,
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 4,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Summary',
                        style: context.bodySmall.copyWith(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Image.asset(
                        AppAssetPaths.viewSummaryIcon,
                        width: 16,
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _thumbnailRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(thumbnailAssets.length.clamp(0, 3), (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SizedBox(width: 80, child: _thumbnailSlot(index, context)),
        );
      }),
    );
  }

  Widget _thumbnailSlot(int index, BuildContext context) {
    if (index == 2 && thumbnailAssets.length > 3) {
      int overflowCount =
          thumbnailAssets.length - 2; // e.g., if 5 total, shows +3
      return _thumbClip(
        child: Container(
          color: AppColors.aliceBlueColor, // That #DFE9FA color we named!
          alignment: Alignment.center,
          child: Text(
            '+$overflowCount',
            style: context.titleMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: const Color(0xff434654),
            ),
          ),
        ),
      );
    }

    // Scenario 2: Normal Image slot
    return _thumbClip(
      child: AppCachedNetworkImage(
        imageUrl: thumbnailAssets[index],
        boxFit: BoxFit.cover,
        height: _thumbSize,
        canOpenImage: true,
      ),
    );
  }

  Widget _thumbClip({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(height: _thumbSize, child: child),
    );
  }
}
