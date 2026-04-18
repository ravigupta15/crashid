import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/notification/presentation/widgets/notification_case_detail_row_widget.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({
    super.key,
    required this.title,
    this.onSecondaryTap,
    this.onPrimaryTap,
  });
  final String title;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const SizedBox(height: 16),
          (title.toLowerCase().contains('emergency')) ?
          AppElevatedButton.withTitleAndIcon(
            icon: Image.asset(AppAssetPaths.runIcon),
            color: AppColors.crimsonRedColor,
            textColor: AppColors.whiteColor,
            width: double.infinity,
            title: "I am Coming",
            height: 48,
            isBoxShadow: false,
            onPressed: () {},
          ) : 
          Row(
            children: [
              Expanded(child: AppElevatedButton.withTitle(title: "Accept",
              textColor: AppColors.whiteColor,
              isBoxShadow: false,
              height: 48,
               onPressed: (){},)),
               const SizedBox(width: 12,),
              Expanded(child: AppElevatedButton.withTitle(title: "Reject",
              color: AppColors.aliceBlueColor,
              isBoxShadow: false,
              height: 48,
              textColor: AppColors.blackColor, onPressed: (){},)),
            ],
          )
        ],
      ),
    );
  }

  Widget _headerRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: title.toLowerCase().contains("emergency")
                ? Color(0xffFFDAD6).withValues(alpha: .2)
                : AppColors.iceColor,
          ),
          child: Image.asset(
            title.toLowerCase().contains('emergency')
                ? AppAssetPaths.emergencyRequestIcon
                : title.toLowerCase().contains('witness')
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
                      title,
                      style: context.titleMedium.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: title.toLowerCase().contains('emergency')
                            ? AppColors.crimsonRedColor
                            : AppColors.darkGrayColor,
                      ),
                    ),
                  ),
                  if (title.toLowerCase().contains('accident'))
                    Text(
                      '1h ago',
                      style: context.bodySmall.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff434654).withValues(alpha: .6),
                      ),
                    ),
                  if (title.toLowerCase().contains('witness'))
                    Container(
                      height: 19,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.aliceBlueColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "NEW",
                        style: context.bodySmall.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  if (title.toLowerCase().contains('emergency'))
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
                  if (title.toLowerCase().contains('emergency')) ...[
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
                  if (title.toLowerCase().contains('witness')) ...[
                    Text.rich(
                      TextSpan(
                        text: " You were added as a witness foran accident ",
                        style: context.bodyMedium.copyWith(fontSize: 16),
                        children: [
                          TextSpan(
                            text: "(RJ45 2039 & RJ142948)",
                            style: context.titleMedium.copyWith(fontSize: 16),
                            children: [
                              TextSpan(
                                text: ". Accept if you saw it.",
                                style: context.bodyMedium.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (title.toLowerCase().contains('accident')) ...[
                    Text(
                      "A request to file a report for your recent accident has been initiated.",
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
            'MG Road, Sector 14, Gurgaon',
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
          NotificationCaseDetailRowWidget(label: 'Case ID', value: '#GS-99210'),
          const SizedBox(height: 6),
          NotificationCaseDetailRowWidget(
            label: 'Date/Time',
            value: 'Oct 24, 02:45 PM',
          ),
          const SizedBox(height: 6),
          NotificationCaseDetailRowWidget(
            label: 'Location',
            value: 'Cyber Hub, Gurgaon',
          ),
        ],
      ),
    );
  }
}