import 'package:crashid/features/add_accident/model/accident_response_model.dart';
import 'package:crashid/features/add_accident/model/pricing_response_model.dart';
import 'package:crashid/features/emergency/add_emergency/model/search_user_response_model.dart';

class OtherAccidentState {
  final bool? isLoading;
  SearchUserResponseModel? searchUserResponseModel;
  PricingResponseModel? pricingResponseModel;
  AccidentResponseModel? accidentResponseModel;

  OtherAccidentState({this.isLoading, 
  this.searchUserResponseModel,
  this.pricingResponseModel, 
  this.accidentResponseModel});

  OtherAccidentState.initial() : isLoading = false,
   searchUserResponseModel = null, 
   pricingResponseModel= null,
   accidentResponseModel = null;

  OtherAccidentState copyWith({bool? isLoading,
   SearchUserResponseModel? searchUserResponseModel,
    PricingResponseModel? pricingResponseModel,
    AccidentResponseModel? accidentResponseModel }) {
    return OtherAccidentState(
      isLoading: isLoading ?? this.isLoading,
      searchUserResponseModel: searchUserResponseModel ?? this.searchUserResponseModel,
      pricingResponseModel: pricingResponseModel ?? this.pricingResponseModel,
      accidentResponseModel: accidentResponseModel ?? this.accidentResponseModel
    );
  }
}
