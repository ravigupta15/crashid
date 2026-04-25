
  import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<ImageSource?> showImageSourcePicker() {
    return showModalBottomSheet<ImageSource>(
      context: AppRouter.mainNavigatorKey.currentContext!,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title:  Text('Gallery', style: context.bodyMedium.copyWith(
                  color: AppColors.darkGrayColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                )),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title:  Text('Camera', style: context.bodyMedium.copyWith(
                  color: AppColors.darkGrayColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                )),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );
  }
