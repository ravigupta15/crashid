import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class AppRadioButtonWithCheckicon extends StatelessWidget {
   final int selectedIndex;
  final int index;
  final String title;
  final void Function(int)? onChanged;
 
  const AppRadioButtonWithCheckicon({super.key,
      required this.selectedIndex,
      required this.index,
      this.title = '',
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onChanged?.call(index);
      },
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIndex == index ? AppColors.primaryColor : AppColors.whiteColor,
                border: Border.all(
                  width: 2,
                  color: selectedIndex == index ?
                  AppColors.primaryColor :
                   AppColors.lightGrayColor),
                ),
                padding: EdgeInsets.all(1),
                alignment: Alignment.center,
            child: selectedIndex == index
                ? Icon(Icons.check, size: 14,
                color: AppColors.whiteColor,
                )
                : null,
          ),
          if (title.isNotEmpty) ...[
            const SizedBox(
              width: 12,
            ),
            Text(
               title,
              style: context.labelMedium.copyWith(
                color: AppColors.blackColor,
                 fontSize: 16,
                 fontWeight: FontWeight.w500
              ),
            )
          ]
        ],
      ),
    );
  }
}
