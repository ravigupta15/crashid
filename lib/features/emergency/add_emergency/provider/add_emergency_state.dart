import 'package:crashid/features/emergency/add_emergency/model/search_user_response_model.dart';

class AddEmergencyState {
  final bool? isLoading;
  SearchUserResponseModel? searchUserResponseModel;

  AddEmergencyState({this.isLoading, this.searchUserResponseModel, });

  AddEmergencyState.initial() : isLoading = false, searchUserResponseModel = null;

  AddEmergencyState copyWith({bool? isLoading, SearchUserResponseModel? searchUserResponseModel}) {
    return AddEmergencyState(
      isLoading: isLoading ?? this.isLoading,
      searchUserResponseModel: searchUserResponseModel ?? this.searchUserResponseModel
    );
  }
}
