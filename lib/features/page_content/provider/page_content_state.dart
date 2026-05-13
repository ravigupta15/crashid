import 'package:crashid/features/page_content/model/page_content_response_model.dart';

class PageContentState {
  final bool isLoading;
  final PageContentResponseModel? pageContentResponseModel;

  const PageContentState({
    required this.isLoading,
    this.pageContentResponseModel,
  });

  factory PageContentState.initial() {
    return const PageContentState(
      isLoading: false,
      pageContentResponseModel  : null,
    );
  }

  PageContentState copyWith({
    bool? isLoading,
    PageContentResponseModel? pageContentResponseModel,
  }) {
    return PageContentState(
      isLoading: isLoading ?? this.isLoading,
      pageContentResponseModel: pageContentResponseModel ?? this.pageContentResponseModel,
    );
  }
}
