class MdModel {
  bool? success;
  String? message;
  List<Data>? data;

  MdModel({this.success, this.message, this.data});

  MdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add( Data.fromJson(v));
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

class Data {
  dynamic id;
  dynamic name;
  dynamic brandId;
  dynamic brandName;
  dynamic isActive;
  dynamic createdAt;

  Data(
      {this.id,
      this.name,
      this.brandId,
      this.brandName,
      this.isActive,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['brand_id'] = brandId;
    data['brand_name'] = brandName;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    return data;
  }
}
