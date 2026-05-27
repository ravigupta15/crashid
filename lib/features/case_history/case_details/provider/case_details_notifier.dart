import 'dart:async';
import 'package:crashid/features/add_accident/repository/accident_repository.dart';
import 'package:crashid/features/case_history/case_details/model/case_details_response_model.dart';
import 'package:crashid/features/case_history/case_details/provider/case_details_state.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

class CaseDetailsNotifier extends AsyncNotifier<CaseDetailsState> {
  @override
  FutureOr<CaseDetailsState> build() {
    return CaseDetailsState.initial();
  }

  Future caseDetails(String? caseId) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(accidentRepositoryProvider);
      final response = await repo.caseDetails(caseId: caseId);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
      state = AsyncData(state.value!.copyWith(caseDetailsResponseModel: CaseDetailsResponseModel.fromJson(response?.data)));
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }

  Future caseClosed(String? caseId) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(accidentRepositoryProvider);
      final response = await repo.caseClosed(caseId: caseId);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        showFeedbackMessage(response?.data['message'] ?? '');
        caseDetails(caseId);
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }


  Future<Response?> userBReject(String? caseId) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(accidentRepositoryProvider);
      final response = await repo.userBReject(caseId: caseId);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        showFeedbackMessage(response?.data['message'] ?? '');
        return response;
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
    return null;
  }
 
}
