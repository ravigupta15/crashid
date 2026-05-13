class PricingResponseModel {
  bool? success;
  String? message;
  Data? data;

  PricingResponseModel({this.success, this.message, this.data});

  PricingResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
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

class Data {
  dynamic serviceCharge;
  dynamic vat;
  dynamic total;
  dynamic currency;

  Data({this.serviceCharge, this.vat, this.total, this.currency});

  Data.fromJson(Map<String, dynamic> json) {
    serviceCharge = json['service_charge'];
    vat = json['vat'];
    total = json['total'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['service_charge'] = serviceCharge;
    data['vat'] = vat;
    data['total'] = total;
    data['currency'] = currency;
    return data;
  }
}
