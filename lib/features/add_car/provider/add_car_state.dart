import 'package:crashid/features/add_car/model/brands_model.dart';
import 'package:crashid/features/add_car/model/colors_model.dart';
import 'package:crashid/features/add_car/model/md_model.dart';
import 'package:crashid/features/my_insurance/model/insurance_response_model.dart';

class AddCarState {
  final bool? isLoading;
  BrandsModel? brandsModel;
  ColorsModel? colorsModel;
  MdModel? mdModel;
  InsuranceResponseModel? insuranceResponseModel;

  AddCarState({this.isLoading, this.brandsModel, this.colorsModel, this.mdModel, this.insuranceResponseModel});

  AddCarState.initial() : isLoading = false, brandsModel = null, colorsModel = null, mdModel = null, insuranceResponseModel = null;

  AddCarState copyWith({bool? isLoading, BrandsModel? brandsModel, ColorsModel? colorsModel, MdModel? mdModel, InsuranceResponseModel? insuranceResponseModel}) {
    return AddCarState(
      isLoading: isLoading ?? this.isLoading,
      brandsModel: brandsModel ?? this.brandsModel,
      colorsModel: colorsModel ?? this.colorsModel,
      mdModel: mdModel ?? this.mdModel,
      insuranceResponseModel: insuranceResponseModel ?? this.insuranceResponseModel,
    );
  }
}
