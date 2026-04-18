import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/features/my_cars/presentation/widgets/my_car_card_widget.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyCarsScreen extends StatefulWidget {

   static void open(BuildContext context) {
    context.push(AppRoutesPath.homeScreen);
  }
  const MyCarsScreen({super.key});

  @override
  State<MyCarsScreen> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<MyCarsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.myCarsTitle,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications, color: AppColors.primaryColor,),
          )
        ],
      ),
      body: _screenContent(),
    );
  }

   // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------
 
 Widget _screenContent() {
  return Padding(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: AppElevatedButton.withTitleAndIcon(
            icon: Icon(Icons.add, color: AppColors.accentColor,),
             title: AppLocalizations.of(context)!.addCarTitle, 
             width: 120,
             borderRadius: 12,
             onPressed: (){},), ),
             const SizedBox(height: 2,),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            itemCount: 2,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return  MyCarCardWidget(
                carName: 'Volkswagen Ameo',
                licensePlate: 'SE-SB 1992',
                fuelType: 'Petrol',
                insuranceNumber: '123456789',
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
          ),
        ),
      ],
    ),
  );
 }
}