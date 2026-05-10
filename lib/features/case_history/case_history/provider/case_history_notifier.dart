import 'dart:async';
import 'package:crashid/features/add_accident/repository/accident_repository.dart';
import 'package:crashid/features/case_history/case_history/provider/case_history_state.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CaseHistoryNotifier extends AsyncNotifier<CaseHistoryState> {
  @override
  FutureOr<CaseHistoryState> build() {
    return CaseHistoryState.initial();
  }

  Future caseHistory(BuildContext context, {String? currentTab}) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(accidentRepositoryProvider);
      final response = await repo.caseHistory(currentTab: currentTab);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }

 
}
