import 'dart:async';
import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/features/add_accident/model/accident_response_model.dart';
import 'package:crashid/features/add_accident/model/other_accident_send_model.dart';
import 'package:crashid/features/add_accident/model/pricing_response_model.dart';
import 'package:crashid/features/add_accident/presentation/pages/payment_webview_screen.dart';
import 'package:crashid/features/add_accident/provider/other_accident_state.dart';
import 'package:crashid/features/add_accident/repository/accident_repository.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtherAccidentNotifier extends AsyncNotifier<OtherAccidentState> {
  @override
  FutureOr<OtherAccidentState> build() {
    return OtherAccidentState.initial();
  }


  Future pricing() async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(accidentRepositoryProvider);
      final response = await repo.pricing();
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        state = AsyncData(state.value!.copyWith(pricingResponseModel: PricingResponseModel.fromJson(response?.data)));
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }


  Future complete(OtherAccidentSendModel? sendModel, {String? route}) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(accidentRepositoryProvider);
      final response = await repo.completeAccident(sendModel);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        var model = AccidentResponseModel.fromJson(response?.data);
        _openPaymentWebviewScreen(caseId: sendModel?.caseId, 
        paymentUrl: model.data?.paymentSummary?.approveUrl,
        route: route
        );
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }

  
  Future paymentcapture({String? caseId, String? paypalOrderId, String? route}) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(accidentRepositoryProvider);
      final response = await repo.paymentCapture(caseId: caseId, paypalOrderId: paypalOrderId);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        final context = AppRouter.mainNavigatorKey.currentContext!;
        showFeedbackMessage(response?.data['message'], context: context, feedbackStyle: FeedbackStyle.snackBar, snackBarBgColor: Colors.green);

        if (route == "case_details") { 
        Navigator.pop(context);
        } else {
        Navigator.pop(context);
        Navigator.pop(context);
        }
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }

  void _openPaymentWebviewScreen({String? caseId, String? paymentUrl, String? route}) {
    PaymentWebviewScreen.open(AppRouter.mainNavigatorKey.currentContext!, 
    paymentUrl: paymentUrl,
    ).then((val) {
      if (val != null) {
        paymentcapture(caseId: caseId, paypalOrderId: val, route: route);
      }
    });
  }

  

}
