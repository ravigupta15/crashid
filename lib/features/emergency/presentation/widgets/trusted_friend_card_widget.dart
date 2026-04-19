import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class TrustedFriendCardWidget extends StatelessWidget {
  final String name;
  final String email;
  final String plateNumber;
  final String badgeLabel;
  final String initial;
  final VoidCallback? onDetails;

  const TrustedFriendCardWidget({
    super.key,
    required this.name,
    required this.email,
    required this.plateNumber,
    required this.badgeLabel,
    required this.initial,
    this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Avatar(initial: initial),
              Container(
                height: 23,
                width: 67,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.aliceBlueColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badgeLabel.toUpperCase(),
                  style: context.labelSmall.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            name,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Color(0xff121C28),
            ),
          ),
          const SizedBox(height: 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.mail_outline_rounded,
                size: 16,
                color: Color(0xff434654),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  email,
                  style: context.bodySmall.copyWith(
                    fontSize: 14,
                    color: Color(0xff434654),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Color(0xffEEF4FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Text(
                  'PLATE NUMBER',
                  style: context.bodyMedium.copyWith(
                    fontSize: 12,
                    // fontWeight: FontWeight.w500,
                    color: Color(0xff737686),
                  ),
                ),
                const Spacer(),
                Text(
                  plateNumber,
                  style: context.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          AppElevatedButton.withTitle(
            title: 'Details',
            onPressed: onDetails,
            color: AppColors.aliceBlueColor,
            textColor: Color(0xff434654),
            fontWeight: FontWeight.w500,
            fontSize: 14,
            isBoxShadow: false,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String initial;

  const _Avatar({required this.initial});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.darkGrayColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 4,
            color: AppColors.blackColor.withValues(alpha: .05),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: context.headlineSmall.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 30,
          color: AppColors.darkGrayColor,
        ),
      ),
    );
  }
}
