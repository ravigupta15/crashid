class CarDetailsResponseModel {
  bool? success;
  String? message;
  CarDetailsModel? data;

  CarDetailsResponseModel({this.success, this.message, this.data});

  CarDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  CarDetailsModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class CarDetailsModel {
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
  dynamic updatedAt;
  dynamic insuranceId;
  dynamic insuranceCompanyName;
  dynamic insuranceNumber;
  dynamic insuranceEmail;
  dynamic validFrom;
  dynamic validUntil;
  dynamic insuranceImage;
  List<Images>? images;

  CarDetailsModel(
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
      this.updatedAt,
      this.insuranceId,
      this.insuranceCompanyName,
      this.insuranceNumber,
      this.insuranceEmail,
      this.validFrom,
      this.validUntil,
      this.insuranceImage,
      this.images});

  CarDetailsModel.fromJson(Map<String, dynamic> json) {
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
    updatedAt = json['updated_at'];
    insuranceId = json['insurance_id'];
    insuranceCompanyName = json['insurance_company_name'];
    insuranceNumber = json['insurance_number'];
    insuranceEmail = json['insurance_email'];
    validFrom = json['valid_from'];
    validUntil = json['valid_until'];
    insuranceImage = json['insurance_image'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images?.add(new Images.fromJson(v));
      });
    }
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
    data['updated_at'] = updatedAt;
    data['insurance_id'] = insuranceId;
    data['insurance_company_name'] = insuranceCompanyName;
    data['insurance_number'] = insuranceNumber;
    data['insurance_email'] = insuranceEmail;
    data['valid_from'] = validFrom;
    data['valid_until'] = validUntil;
    data['insurance_image'] = insuranceImage;
    if (images != null) {
      data['images'] = images?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  dynamic id;
  dynamic imagePath;
  dynamic isPrimary;
  dynamic imageUrl;

  Images({this.id, this.imagePath, this.isPrimary, this.imageUrl});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['image_path'];
    isPrimary = json['is_primary'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['image_path'] = imagePath;
    data['is_primary'] = isPrimary;
    data['image_url'] = imageUrl;
    return data;
  }
}
