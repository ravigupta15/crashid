import 'dart:io';

import 'package:crashid/core/service/image_picker_service.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/image_picker_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHeader extends StatefulWidget {
  final String initials;
  final String displayName;
  final VoidCallback? onEdit;

  const ProfileHeader({
    super.key,
    required this.initials,
    required this.displayName,
    this.onEdit,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: widget.onEdit,
            icon: Icon(
              Icons.edit_outlined,
              size: 18,
              color: AppColors.primaryColor,
            ),
            label: Text(
              AppLocalizations.of(context)!.edit,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.darkGrayColor.withValues(alpha: 0.10 ),
              border: Border.all(color: AppColors.whiteColor, width: 1),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.initials,
              style: context.headlineMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                    color: AppColors.primaryColor,
                  ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.displayName,
          textAlign: TextAlign.center,
          style: context.titleLarge.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: AppColors.darkGrayColor,
              ),
        ),
      ],
    );
  }

    Future<void> _pickDocumentImage({
    required ValueChanged<File?> onPicked,
  }) async {
    final ImageSource? source = await showImageSourcePicker();
    if (source == null) return;
    final File? file = await ImagePickerService.imagePicker(source);
    if (file == null) return;
    setState(() {
      onPicked(file);
    });
  }

}
