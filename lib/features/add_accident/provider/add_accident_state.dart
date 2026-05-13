import 'package:crashid/features/add_accident/model/pricing_response_model.dart';
import 'package:crashid/features/emergency/add_emergency/model/search_user_response_model.dart';

class AddAccidentState {
  final bool? isLoading;
  SearchUserResponseModel? searchUserResponseModel;
  PricingResponseModel? pricingResponseModel;

  AddAccidentState({this.isLoading, this.searchUserResponseModel,this.pricingResponseModel});

  AddAccidentState.initial() : isLoading = false, searchUserResponseModel = null, pricingResponseModel= null;

  AddAccidentState copyWith({bool? isLoading, SearchUserResponseModel? searchUserResponseModel, PricingResponseModel? pricingResponseModel}) {
    return AddAccidentState(
      isLoading: isLoading ?? this.isLoading,
      searchUserResponseModel: searchUserResponseModel ?? this.searchUserResponseModel,
      pricingResponseModel: pricingResponseModel ?? this.pricingResponseModel
    );
  }
}
