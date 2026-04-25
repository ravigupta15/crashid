import 'package:crashid/features/add_car/model/brands_model.dart';
import 'package:crashid/features/add_car/model/colors_model.dart';
import 'package:crashid/features/add_car/model/md_model.dart';

class AddCarState {
  final bool? isLoading;
  BrandsModel? brandsModel;
  ColorsModel? colorsModel;
  MdModel? mdModel;

  AddCarState({this.isLoading, this.brandsModel, this.colorsModel, this.mdModel});

  AddCarState.initial() : isLoading = false, brandsModel = null, colorsModel = null, mdModel = null;

  AddCarState copyWith({bool? isLoading, BrandsModel? brandsModel, ColorsModel? colorsModel, MdModel? mdModel}) {
    return AddCarState(
      isLoading: isLoading ?? this.isLoading,
      brandsModel: brandsModel ?? this.brandsModel,
      colorsModel: colorsModel ?? this.colorsModel,
      mdModel: mdModel ?? this.mdModel,
    );
  }
}
