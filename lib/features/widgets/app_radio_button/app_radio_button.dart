import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/extensions/extension_string.dart';
import 'package:flutter/material.dart';

class AppRadioBtnWithOptionalTitle extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final String title;
  final void Function(int)? onChanged;
  final bool? isTitleFirst;
  const AppRadioBtnWithOptionalTitle(
      {super.key,
      required this.selectedIndex,
      required this.index,
      this.title = '',
      this.onChanged,
      this.isTitleFirst});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onChanged?.call(index);
      },
      child: Row(
        children: [
          if ((isTitleFirst ?? false) && title.isNotNullOrNotEmpty )...[
            Text(
               title,
              style: context.labelMedium.copyWith(
                color: AppColors.darkGrayColor.withValues(alpha: .6),
                 fontSize: 14,
                 fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(
              width: 9,
            ),
          ],
          Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.blackColor),
                ),
                padding: EdgeInsets.all(1),
            child: selectedIndex == index
                ? Container(
                  decoration: BoxDecoration(
                    color: AppColors.blackColor,
                    shape: BoxShape.circle
                  ),
                )
                : null,
          ),
          if (!(isTitleFirst ?? false) && title.isNotEmpty) ...[
            const SizedBox(
              width: 9,
            ),
            Text(
               title,
              style: context.labelMedium.copyWith(
                color: AppColors.darkGrayColor.withValues(alpha: .6),
                 fontSize: 14,
                 fontWeight: FontWeight.w500
              ),
            )
          ]
        ],
      ),
    );
  }
}
