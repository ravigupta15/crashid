class MyCarResponseModel {
  bool? success;
  String? message;
  List<CarData>? data;

  MyCarResponseModel({this.success, this.message, this.data});

  MyCarResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CarData>[];
      json['data'].forEach((v) {
        data?.add( CarData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarData {
  dynamic id;
  dynamic plateNumber;
  dynamic carName;
  dynamic brandId;
  dynamic brand;
  dynamic modelId;
  dynamic model;
  dynamic fuelType;
  dynamic colorId;
  dynamic color;
  dynamic colorHex;
  dynamic registrationDate;
  dynamic finVin;
  dynamic isDefault;
  dynamic createdAt;
  dynamic primaryImage;
  dynamic insuranceCompanyName;
  dynamic insuranceNumber;
  dynamic validFrom;
  dynamic validUntil;
  dynamic primaryImageUrl;

  CarData(
      {this.id,
      this.plateNumber,
      this.carName,
      this.brandId,
      this.brand,
      this.modelId,
      this.model,
      this.fuelType,
      this.colorId,
      this.color,
      this.colorHex,
      this.registrationDate,
      this.finVin,
      this.isDefault,
      this.createdAt,
      this.primaryImage,
      this.insuranceCompanyName,
      this.insuranceNumber,
      this.validFrom,
      this.validUntil,
      this.primaryImageUrl});

  CarData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plateNumber = json['plate_number'];
    carName = json['car_name'];
    brandId = json['brand_id'];
    brand = json['brand'];
    modelId = json['model_id'];
    model = json['model'];
    fuelType = json['fuel_type'];
    colorId = json['color_id'];
    color = json['color'];
    colorHex = json['color_hex'];
    registrationDate = json['registration_date'];
    finVin = json['fin_vin'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    primaryImage = json['primary_image'];
    insuranceCompanyName = json['insurance_company_name'];
    insuranceNumber = json['insurance_number'];
    validFrom = json['valid_from'];
    validUntil = json['valid_until'];
    primaryImageUrl = json['primary_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['plate_number'] = plateNumber;
    data['car_name'] = carName;
    data['brand_id'] = brandId;
    data['brand'] = brand;
    data['model_id'] = modelId;
    data['model'] = model;
    data['fuel_type'] = fuelType;
    data['color_id'] = colorId;
    data['color'] = color;
    data['color_hex'] = colorHex;
    data['registration_date'] = registrationDate;
    data['fin_vin'] = finVin;
    data['is_default'] = isDefault;
    data['created_at'] = createdAt;
    data['primary_image'] = primaryImage;
    data['insurance_company_name'] = insuranceCompanyName;
    data['insurance_number'] = insuranceNumber;
    data['valid_from'] = validFrom;
    data['valid_until'] = validUntil;
    data['primary_image_url'] = primaryImageUrl;
    return data;
  }
}
