class InsuranceResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  InsuranceResponseModel({this.success, this.message, this.data});

  InsuranceResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic insuranceId;
  dynamic insuranceCompanyName;
  dynamic insuranceNumber;
  dynamic insuranceEmail;
  dynamic validFrom;
  dynamic validUntil;
  dynamic insuranceImage;
  dynamic vehicleId;
  dynamic plateNumber;
  dynamic carName;
  dynamic brand;
  dynamic model;
  dynamic color;
  dynamic colorHex;
  dynamic insuranceImageUrl;

  Data(
      {this.insuranceId,
      this.insuranceCompanyName,
      this.insuranceNumber,
      this.insuranceEmail,
      this.validFrom,
      this.validUntil,
      this.insuranceImage,
      this.vehicleId,
      this.plateNumber,
      this.carName,
      this.brand,
      this.model,
      this.color,
      this.colorHex,
      this.insuranceImageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    insuranceId = json['insurance_id'];
    insuranceCompanyName = json['insurance_company_name'];
    insuranceNumber = json['insurance_number'];
    insuranceEmail = json['insurance_email'];
    validFrom = json['valid_from'];
    validUntil = json['valid_until'];
    insuranceImage = json['insurance_image'];
    vehicleId = json['vehicle_id'];
    plateNumber = json['plate_number'];
    carName = json['car_name'];
    brand = json['brand'];
    model = json['model'];
    color = json['color'];
    colorHex = json['color_hex'];
    insuranceImageUrl = json['insurance_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['insurance_id'] = insuranceId;
    data['insurance_company_name'] = insuranceCompanyName;
    data['insurance_number'] = insuranceNumber;
    data['insurance_email'] = insuranceEmail;
    data['valid_from'] = validFrom;
    data['valid_until'] = validUntil;
    data['insurance_image'] = insuranceImage;
    data['vehicle_id'] = vehicleId;
    data['plate_number'] = plateNumber;
    data['car_name'] = carName;
    data['brand'] = brand;
    data['model'] = model;
    data['color'] = color;
    data['color_hex'] = colorHex;
    data['insurance_image_url'] = insuranceImageUrl;
    return data;
  }
}
