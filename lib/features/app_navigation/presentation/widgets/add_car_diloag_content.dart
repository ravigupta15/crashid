import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/add_car/presentation/pages/add_car_screen.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddCarDiloagContent extends StatelessWidget {
  final VoidCallback? onClickAddCar;
  const AddCarDiloagContent({super.key, this.onClickAddCar});

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
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.close)),),
          const SizedBox(height: 35,),
          Image.asset(AppAssetPaths.addCarIcon),
          const SizedBox(height: 5,),
          Text(AppLocalizations.of(context)!.addCarToContinueTitle, 
          style: context.titleMedium.copyWith(
            fontSize: 14, fontWeight: FontWeight.w800
          ),
          ),
          const SizedBox(height: 3,),
          Text(AppLocalizations.of(context)!.addCarToContinueDescription,
          textAlign: TextAlign.center,
          style: context.labelMedium.copyWith(
            fontSize: 11, fontWeight: FontWeight.w700,
            color: AppColors.darkGrayColor.withValues(alpha: .6)
          ),
          ),
           const SizedBox(height: 21,),
           AppElevatedButton.withTitle(title: AppLocalizations.of(context)!.addCarTitle, onPressed: onClickAddCar,)
      ],
    ),
  );
}
}
