import 'package:country_picker/country_picker.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class CountryCodeWidget extends StatelessWidget {
  final Country? country;
  final void Function() onTap;
  const CountryCodeWidget({super.key, this.country, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        alignment: Alignment.centerRight,
        child: country != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Text( country!.flagEmoji ,
                  // style: context.titleMedium.copyWith(
                  //   fontSize: 14,
                  //     color: AppColors.blackColor,
                  //     fontWeight: FontWeight.w500
                  // )
                  // ),
                  const SizedBox(width: 8,),
                  Text(
                    "+${country!.phoneCode}",
                    style: context.labelMedium.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 14,
                    color: AppColors.darkGrayColor,
                  ),
                   VerticalDivider(
                    color: AppColors.blackColor, 
                    thickness: 1,
                    indent: 10, 
                    endIndent: 10,
                  ),
                ],
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
