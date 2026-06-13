import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/add_accident/model/add_accident_send_model.dart';
import 'package:crashid/features/add_accident/presentation/pages/add_accident_screen.dart';
import 'package:crashid/features/case_history/case_details/presentation/pages/case_details_screen.dart';
import 'package:crashid/features/case_history/case_details/provider/case_details_notifier.dart';
import 'package:crashid/features/case_history/case_details/provider/case_details_state.dart';
import 'package:crashid/features/notification/presentation/widgets/notification_card_widget.dart';
import 'package:crashid/features/notification/provider/notification_notifier.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:crashid/utils/no_data_found/no_data_found.dart';
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

  AddAccidentSendModel? sendModel;
@override
  void initState() {
    sendModel = AddAccidentSendModel(
    );
    Future.microtask(() => 
    _callNotificationApi());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: CustomAppBar(
        title: 'Notifications',
        isShowAction: false,
       
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
    return (notificationModel?.notifications ?? []).isNotEmpty ?
    ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemCount: notificationModel?.notifications?.length ?? 0,
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      itemBuilder: (context, index) {
        var model = notificationModel?.notifications?[index];
        return  NotificationCardWidget(
            model: model,
            onPrimaryTap: () => _openAccidentScreen((model?.caseId ?? '').toString()),
            onSecondaryTap: () => _openDialogBox((model?.caseId ?? '').toString(), (model?.type ?? '').toString()),
            onTap: () => _openCaseDetailsScreen((model?.caseId ?? '').toString()),
            comingTap: () => _openComingDialogBox((model?.sosId ?? '').toString())
          );
    }) : NoDataFound();
    }

  
void _callNotificationApi() async{
    await ref
        .read(notificationProvider.notifier)
        .getNotificationn();
  }


  void _openAccidentScreen(String? caseId) {
    AddAccidentScreen.open(context,routeName: 'accept', caseId: caseId).then((val) {
      _callNotificationApi();
    });
  }

void _openCaseDetailsScreen(String? caseId) {
   CaseDetailsScreen.open(context, id: caseId).then((val) {
      _callNotificationApi();
    });
  }
  void _openDialogBox(String? caseId, String? type) {
    AppDialogBox().openBox(
      maxWidthMinWidth: MediaQuery.sizeOf(context).width * .8,
      title: "Reject Request",
      subTitle: "Are you sure you want to reject this request?",
      yesTap: () {
        Navigator.pop(context);
        if (type == "witness_request") {
           _callUserWitnessRejectApi(caseId!);
        } else {
        _callUserBRejectApi(caseId!);
      }
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

  
  void _callUserWitnessRejectApi(String caseId) async{
    sendModel?.caseId = caseId;
    sendModel?.witnessAction = "rejected";
    await ref
        .read(casedetailsNotifierProvider.notifier)
        .userWitnessReject(sendModel: sendModel).then((response) {
          if(response?.statusCode == 201 || response?.statusCode == 200){
            _callNotificationApi();
          }
        });
  }

 void _openComingDialogBox(String? sosId) {
    AppDialogBox().openBox(
      maxWidthMinWidth: MediaQuery.sizeOf(context).width * .8,
      title: "Accept Request",
      subTitle: "Are you sure you want to accept this request?",
      yesTap: () {
        Navigator.pop(context);
        _sosRespond(sosId);
       
      }
    );
  }

  void _sosRespond(String? sosId) async{
    await ref.read(notificationProvider.notifier).sosRespond(sosId: sosId, action: "coming");
  }

}
