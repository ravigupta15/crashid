import 'dart:async';
import 'package:crashid/features/lookup/repository/lookup_repository.dart';
import 'package:crashid/features/page_content/model/page_content_response_model.dart';
import 'package:crashid/features/page_content/provider/page_content_state.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageContentNotifier extends AsyncNotifier<PageContentState> {
  @override
  FutureOr<PageContentState> build() {
    return PageContentState.initial();
  }

  Future<void> pageContent(String? slug) async {
    try {
      LoaderService().showLoader();
      final repo = ref.read(lookupRepositoryProvider);
      final response = await repo.pageContentApi(slug);
      if (response?.statusCode == 200 ) {
        final model = PageContentResponseModel.fromJson(response?.data);
        state = AsyncData(state.value!.copyWith(
          pageContentResponseModel: model,
        ));
      }
    } catch (_) {
    }
     finally {
      LoaderService().hideLoader();
    }
  }

}

