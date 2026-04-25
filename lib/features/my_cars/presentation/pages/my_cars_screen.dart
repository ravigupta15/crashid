import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/features/add_car/presentation/pages/add_car_screen.dart';
import 'package:crashid/features/my_cars/presentation/pages/car_details_screen.dart';
import 'package:crashid/features/my_cars/presentation/widgets/my_car_card_widget.dart';
import 'package:crashid/features/my_cars/provider/my_car_notifier.dart';
import 'package:crashid/features/my_cars/provider/my_car_state.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/extensions/extension_navigator.dart';
import 'package:crashid/utils/no_data_found/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyCarsScreen extends ConsumerStatefulWidget {

   static void open(BuildContext context) {
    context.push(AppRoutesPath.myCarsScreen);
  }

  
   static void openRemoveUntil(BuildContext context) {
    context.pushNamedAndRemoveUntil(AppRoutesPath.myCarsScreen);
  }
  const MyCarsScreen({super.key});

  @override
  ConsumerState<MyCarsScreen> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends ConsumerState<MyCarsScreen> {
 
 
final myCarNotifierProvider =
    AsyncNotifierProvider<MyCarNotifier, MyCarState>(MyCarNotifier.new);

   
   @override
  void initState() {
    _callMyCarApi();
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.myCarsTitle,
        
      ),
      body: _screenContent(),
    );
  }

   // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------
 
 Widget _screenContent() {
  final refState = ref.watch(myCarNotifierProvider);
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
             height: 48,
             borderRadius: 12,
             isBoxShadow: false,
             onPressed: _openAddCarScreen,), ),
             const SizedBox(height: 2,),
        Expanded(
          child: (refState.value?.myCarResponseModel?.data ?? []).isEmpty ?
          NoDataFound() :
           ListView.separated(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            itemCount: refState.value?.myCarResponseModel?.data?.length ?? 0,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              var model = refState.value?.myCarResponseModel?.data?[index];
              return  MyCarCardWidget(
                model: model,
                onTap: () => _openCarDetailsScreen((model?.id ?? '')?.toString()),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
          ),
        ),
      ],
    ),
  );
 }

 
   // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------
 
 void _openAddCarScreen() {
  AddCarScreen.open(context);
 }

 void _openCarDetailsScreen(String? id) {
  CarDetailsScreen.open(context, id);
 }

 
void _callMyCarApi() async{
    await ref
        .read(myCarNotifierProvider.notifier)
        .myCar(context);
  }

}