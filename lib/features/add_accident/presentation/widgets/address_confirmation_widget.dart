import 'package:flutter/material.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';

class AddressConfirmationWidget extends StatelessWidget {
  final VoidCallback? onClickCorrect;
  final VoidCallback? onClickEdit;
  const AddressConfirmationWidget({super.key, this.onClickCorrect, this.onClickEdit});

  @override
  Widget build(BuildContext context) {
    return _screenContent(context);
  }

  
   // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

Widget _screenContent(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 15, bottom: 40, right: 15 ,left: 15),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close)),
          ],
        ),
          const SizedBox(height: 15,),
          Text("Is this address correct?",
          textAlign: TextAlign.center,
          style: context.labelMedium.copyWith(
            fontSize: 13, fontWeight: FontWeight.w700,
            color: AppColors.blackColor
          ),
          ),
           const SizedBox(height: 41,),
           Row(
            children: [
           Expanded(child: AppElevatedButton.withTitle(title: "Yes, Correct", onPressed: onClickCorrect,)),
           const SizedBox(width: 10,),
           Expanded(child: AppElevatedButton.withTitle(title: "Edit Address", onPressed: onClickEdit,))
            ],
           )
      ],
    ),
  );
}
}