
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class EditProfileDocumentRow extends StatelessWidget {
  const EditProfileDocumentRow({
    required this.frontAsset,
    required this.backAsset,
    this.onUpdateDocs,
  });

  final String frontAsset;
  final String backAsset;
  final VoidCallback? onUpdateDocs;

  static const double _thumbAspect = 3 / 2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _thumbWithLabel(
                  context,
                  label: AppLocalizations.of(context)!.documentFront,
                  assetPath: frontAsset,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _thumbWithLabel(
                  context,
                  label: AppLocalizations.of(context)!.documentBack,
                  assetPath: backAsset,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        AppElevatedButton.withTitle(
          onPressed: onUpdateDocs,
          title: AppLocalizations.of(context)!.profileUpdateDocs,
          height: 40,
          width: 104,
          isBoxShadow: false,
          fontSize: 11,
          color: Color(0xff00509D),
          textColor: AppColors.whiteColor,
        ),
      ],
    );
  }

  Widget _thumbWithLabel(
    BuildContext context, {
    required String label,
    required String assetPath,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: context.bodySmall.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.labelMedium,
          ),
        ),
        const SizedBox(height: 6),
        AspectRatio(
          aspectRatio: _thumbAspect,
          child: Image.asset(
            assetPath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ],
    );
  }
}
