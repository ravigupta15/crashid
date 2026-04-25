import 'package:crashid/features/my_cars/model/car_details_response_model.dart';
import 'package:crashid/features/my_cars/model/my_car_response_model.dart';

class MyCarState {
  final bool? isLoading;
  MyCarResponseModel? myCarResponseModel;
  CarDetailsResponseModel? carDetailsResponseModel;

  MyCarState({this.isLoading, this.myCarResponseModel, this.carDetailsResponseModel});

  MyCarState.initial() : isLoading = false, myCarResponseModel = null, carDetailsResponseModel = null;

  MyCarState copyWith({bool? isLoading, MyCarResponseModel? myCarResponseModel, CarDetailsResponseModel? carDetailsResponseModel}) {
    return MyCarState(
      isLoading: isLoading ?? this.isLoading,
      myCarResponseModel: myCarResponseModel ?? this.myCarResponseModel,
      carDetailsResponseModel: carDetailsResponseModel ?? this.carDetailsResponseModel,
    );
  }
}
