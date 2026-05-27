import 'package:crashid/features/add_accident/model/pricing_response_model.dart';
import 'package:crashid/features/emergency/add_emergency/model/search_user_response_model.dart';
import 'package:crashid/features/my_cars/model/my_car_response_model.dart';

class AddAccidentState {
  final bool? isLoading;
  SearchUserResponseModel? searchUserResponseModel;
  PricingResponseModel? pricingResponseModel;
  MyCarResponseModel? myCarResponseModel;

  AddAccidentState({this.isLoading, this.searchUserResponseModel,this.pricingResponseModel, this.myCarResponseModel});

  AddAccidentState.initial() : isLoading = false, searchUserResponseModel = null, pricingResponseModel= null, myCarResponseModel = null;

  AddAccidentState copyWith({bool? isLoading, SearchUserResponseModel? searchUserResponseModel, PricingResponseModel? pricingResponseModel, MyCarResponseModel? myCarResponseModel}) {
    return AddAccidentState(
      isLoading: isLoading ?? this.isLoading,
      searchUserResponseModel: searchUserResponseModel ?? this.searchUserResponseModel,
      pricingResponseModel: pricingResponseModel ?? this.pricingResponseModel,
      myCarResponseModel: myCarResponseModel ?? this.myCarResponseModel
    );
  }
}
