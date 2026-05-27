import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/add_accident/presentation/pages/add_accident_screen.dart';
import 'package:crashid/features/case_history/case_details/provider/case_details_notifier.dart';
import 'package:crashid/features/case_history/case_details/provider/case_details_state.dart';
import 'package:crashid/features/notification/presentation/widgets/notification_card_widget.dart';
import 'package:crashid/features/notification/provider/notification_notifier.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  static void open(BuildContext context) {
    context.push(AppRoutesPath.notificationScreen);
  }

  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  

  
final casedetailsNotifierProvider =
    AsyncNotifierProvider<CaseDetailsNotifier, CaseDetailsState>(CaseDetailsNotifier.new);

  
@override
  void initState() {
    _callNotificationApi();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: CustomAppBar(
        title: 'Notifications',
       
      ),
      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    final refState = ref.watch(notificationProvider);
    var notificationModel = refState.value?.notificationResponseModel?.data;
    return  ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemCount: notificationModel?.notifications?.length ?? 0,
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      itemBuilder: (context, index) {
        var model = notificationModel?.notifications?[index];
        return  NotificationCardWidget(
            model: model,
            onPrimaryTap: () => _openAccidentScreen((model?.caseId ?? '').toString()),
            onSecondaryTap: () => _openDialogBox((model?.caseId ?? '').toString(), ),
          );
    });
    
    // SingleChildScrollView(
    //   padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       // Text(
    //       //   'TODAY',
    //       //   style: context.titleMedium.copyWith(
    //       //     fontSize: 14,
    //       //     fontWeight: FontWeight.w700,
    //       //     color: AppColors.blackColor,
    //       //   ),
    //       // ),
    //       // const SizedBox(height: 15),
    //       NotificationCardWidget(
    //         title: 'Emergency Alert',
    //         onPrimaryTap: () {},
    //       ),
    //       const SizedBox(height: 14),
    //       NotificationCardWidget(
    //         title: 'Witness Request',
    //         onPrimaryTap: () {},
    //         onSecondaryTap: () {},
    //       ),
    //       const SizedBox(height: 14),
    //       NotificationCardWidget(
    //         title: 'Accident Request',
    //         onPrimaryTap: () {},
    //         onSecondaryTap: () {},
    //       ),
    //     ],
    //   ),
    // );
  }

  
void _callNotificationApi() async{
    await ref
        .read(notificationProvider.notifier)
        .getNotificationn(context);
  }


  void _openAccidentScreen(String? caseId) {
    AddAccidentScreen.open(context,routeName: 'accept', caseId: caseId).then((val) {
      _callNotificationApi();
    });
  }

  void _openDialogBox(String? caseId,) {
    AppDialogBox().openBox(
      maxWidthMinWidth: MediaQuery.sizeOf(context).width * .8,
      title: "Reject Request",
      subTitle: "Are you sure you want to reject this request?",
      yesTap: () {
        Navigator.pop(context);
        _callUserBRejectApi(caseId!);
      }
    );
  }

  void _callUserBRejectApi(String caseId) async{
    await ref
        .read(casedetailsNotifierProvider.notifier)
        .userBReject(caseId).then((response) {
          if(response?.statusCode == 201 || response?.statusCode == 200){
            _callNotificationApi();
          }
        });
  }
}
