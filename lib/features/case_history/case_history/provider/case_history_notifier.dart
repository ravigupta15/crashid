import 'dart:async';
import 'package:crashid/features/add_accident/repository/accident_repository.dart';
import 'package:crashid/features/case_history/case_history/provider/case_history_state.dart';
import 'package:crashid/features/case_history/model/case_history_response_model.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final caseHistoryNotifierProvider =
    AsyncNotifierProvider<CaseHistoryNotifier, CaseHistoryState>(
      CaseHistoryNotifier.new,
    );

class CaseHistoryNotifier extends AsyncNotifier<CaseHistoryState> {
  @override
  FutureOr<CaseHistoryState> build() {
    return CaseHistoryState.initial();
  }

  Future caseHistory(BuildContext context, {String? currentTab}) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(accidentRepositoryProvider);
      state = AsyncData(
        state.value!.copyWith(
          caseHistoryResponseModel: CaseHistoryResponseModel.fromJson({}),
        ),
      );
      final response = await repo.caseHistory(currentTab: currentTab);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        state = AsyncData(
          state.value!.copyWith(
            caseHistoryResponseModel: CaseHistoryResponseModel.fromJson(
              response?.data,
            ),
          ),
        );
      }
    } catch (_) {
    } finally {
      LoaderService().hideLoader();
    }
  }
}
