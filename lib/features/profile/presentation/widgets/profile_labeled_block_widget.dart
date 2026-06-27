import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileLabeledBlock extends StatelessWidget {
  final String label;
  final String? value;

  const ProfileLabeledBlock({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: context.labelSmall.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          value ?? AppLocalizations.of(context)!.notAvailable,
          style: context.bodyLarge.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1.35,
                color: AppColors.darkGrayColor,
              ),
        ),
      ],
    );
  }
}
