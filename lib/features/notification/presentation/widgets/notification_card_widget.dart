import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/notification/model/notification_response_model.dart';
import 'package:crashid/features/notification/presentation/widgets/notification_case_detail_row_widget.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/date_format/app_date_format.dart';
import 'package:crashid/utils/empty/empty_widget.dart';
import 'package:crashid/utils/extensions/extension_string.dart';
import 'package:flutter/material.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({
    super.key,
    this.model,
    this.onSecondaryTap,
    this.onPrimaryTap,
    this.onTap

  });
  final Notifications? model;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAccidentType() ? onTap : null,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            _headerRow(context),
      
            (model?.type.toLowerCase().contains('emergency')) ?
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: AppElevatedButton.withTitleAndIcon(
                icon: Image.asset(AppAssetPaths.runIcon),
                color: AppColors.crimsonRedColor,
                textColor: AppColors.whiteColor,
                width: double.infinity,
                title: "I am Coming",
                height: 48,
                isBoxShadow: false,
                onPressed: () {},
              ),
            ) :
            model?.requestStatus == "pending" ?
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  Expanded(child: AppElevatedButton.withTitle(title: "Accept",
                  textColor: AppColors.whiteColor,
                  isBoxShadow: false,
                  height: 48,
                   onPressed: onPrimaryTap,)),
                   const SizedBox(width: 12,),
                  Expanded(child: AppElevatedButton.withTitle(title: "Reject",
                  color: AppColors.aliceBlueColor,
                  isBoxShadow: false,
                  height: 48,
                  textColor: AppColors.blackColor, onPressed: onSecondaryTap,)),
                ],
              ),
            ) : EmptyWidget()
          ],
        ),
      ),
    );
  }

  Widget _headerRow(BuildContext context) {
     var type = model?.type.toLowerCase() ?? '';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: type.contains("emergency")
                ? Color(0xffFFDAD6).withValues(alpha: .2)
                : AppColors.iceColor,
          ),
          child: Image.asset(
            type.contains('emergency')
                ? AppAssetPaths.emergencyRequestIcon
                : type.contains('witness')
                ? AppAssetPaths.witnessRequestIcon
                : AppAssetPaths.accidentRequestIcon,
            width: 22,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      (model?.type ?? '').toString().replaceAll('_', ' ').capitalize,
                      style: context.titleMedium.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: type.contains('emergency')
                            ? AppColors.crimsonRedColor
                            : AppColors.darkGrayColor,
                      ),
                    ),
                  ),
                  if (type.contains('accident') ||
                  type.contains('witness') || type.contains('closed') )
                    Text(
                      AppDateFormat.timeAgo(model?.createdAt ?? ''),
                      style: context.bodySmall.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff434654).withValues(alpha: .6),
                      ),
                    ),
                  // if (model?.type.toLowerCase().contains('witness'))
                  //   Container(
                  //     height: 19,
                  //     width: 40,
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //       color: AppColors.aliceBlueColor,
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     child: Text(
                  //       "NEW",
                  //       style: context.bodySmall.copyWith(
                  //         fontSize: 10,
                  //         fontWeight: FontWeight.w500,
                  //         color: AppColors.primaryColor,
                  //       ),
                  //     ),
                  //   ),
                  if (type.contains('emergency'))
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 2),
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: AppColors.crimsonRedColor,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              Column(
                children: [
                  if (type.contains('emergency')) ...[
                    Text.rich(
                      TextSpan(
                        text: "Rahul Sharma",
                        style: context.titleMedium.copyWith(fontSize: 16),
                        children: [
                          TextSpan(
                            text: " is in an emergency",
                            style: context.bodyMedium.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _locationRow(context),
                  ],
                  if (type.contains('witness')) ...[
                    Text.rich(
                      TextSpan(
                        text: model?.body ?? '',
                        style: context.bodyMedium.copyWith(fontSize: 16),
                        children: [
                          // TextSpan(
                          //   text: "(RJ45 2039 & RJ142948)",
                          //   style: context.titleMedium.copyWith(fontSize: 16),
                          //   children: [
                          //     TextSpan(
                          //       text: ". Accept if you saw it.",
                          //       style: context.bodyMedium.copyWith(
                          //         fontSize: 16,
                          //       ),
                          //     ),
                            // ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                  if (type.contains('accident') || type.contains('closed')) ...[
                    Text(
                      model?.body ?? '',
                      style: context.bodyMedium.copyWith(
                        fontSize: 14,
                        color: Color(0xff434654),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _caseInfoContainer(),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _locationRow(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 16,
          color: AppColors.darkGrayColor.withValues(alpha: 0.55),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            model?.location ?? '',
            style: context.bodySmall.copyWith(
              fontSize: 13,
              color: AppColors.darkGrayColor.withValues(alpha: 0.65),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _caseInfoContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: Color(0xffEEF4FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          NotificationCaseDetailRowWidget(label: 'Case ID', value: '#${model?.caseNumber ?? ''}',),
          const SizedBox(height: 6),
          NotificationCaseDetailRowWidget(
            label: 'Date/Time',
            value: '${AppDateFormat.formatMonthDay(model?.accidentDate)}, ${AppDateFormat.formatTime(model?.accidentTime)}',
          ),
          const SizedBox(height: 6),
          NotificationCaseDetailRowWidget(
            label: 'Location',
            value: model?.location ?? '',
          ),
        ],
      ),
    );
  }

  bool isAccidentType() {
     var type = model?.type.toLowerCase() ?? '';
return
    type.contains('accident') ||
                  type.contains('witness') || type.contains('closed');
  }
}