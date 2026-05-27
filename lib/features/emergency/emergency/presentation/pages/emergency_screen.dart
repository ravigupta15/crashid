import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/emergency/add_emergency/presentation/pages/add_emergency_screen.dart';
import 'package:crashid/features/emergency/emergency/presentation/widgets/trusted_friend_card_widget.dart';
import 'package:crashid/features/emergency/emergency/provider/emergency_notifier.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/no_data_found/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EmergencyScreen extends ConsumerStatefulWidget {
    static const kIsAppbarHide = "/kIsAppbarHide";

  final bool? isAppBarHide;

 
  static void open(BuildContext context, {
    bool? isAppBarHide
  }) {
    context.push(AppRoutesPath.emergencyScreen, extra: {
      kIsAppbarHide: isAppBarHide
    });
  }

  const EmergencyScreen({super.key, this.isAppBarHide});

  @override
  ConsumerState<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends ConsumerState<EmergencyScreen> {
 
  

@override
  void initState() {
    _emergencyApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.isAppBarHide ?? false)? null : CustomAppBar(
        title: 'Emergency',
      ),
      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
  final refState = ref.watch(emergencyNotifier);
  var model = refState.value?.emergencyResponseModel?.data;
    return ColoredBox(
      color: AppColors.screenBackground,
      child: Padding( padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
       
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: AppElevatedButton.withTitleAndIcon(
                          icon: Icon(Icons.add, color: AppColors.whiteColor,),
                           title: "Add New", 
                           width: 120,
                           height: 48,
                           textColor: AppColors.whiteColor,
                           onPressed: _openAddEmergencyScreen,),
            ),
                          Text(
                'Trusted Friends',
                style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.blackColor,
                    ),
              ),
            Expanded(
              child: (model ?? []).isEmpty ?
              NoDataFound() :
                ListView.separated(
                separatorBuilder: (context,sb) => const SizedBox(height: 24,),
                itemCount: model?.length ?? 0,
                padding: EdgeInsets.only(top: 20, bottom: 30),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var f = model?[index];
                return TrustedFriendCardWidget(
                  name: "${f?.firstName ?? ''} ${f?.lastName ?? ''}",
                  email: f?.friendEmail,
                  plateNumber: f?.plateNumber,
                  badgeLabel: "Active",
                  initial: firstLetter(f?.firstName ?? ''),
                  onDetails: () {},
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  
  // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

void _openAddEmergencyScreen() {
  AddEmergencyScreen.open(context);
}

  void _emergencyApi() async{
     await ref.read(emergencyNotifier.notifier).emergencyApi();
  }

  String firstLetter(String item) {
    return item.isEmpty ? '' : item.substring(0)[0];
  }

}
