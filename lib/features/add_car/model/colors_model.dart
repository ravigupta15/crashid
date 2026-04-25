class ColorsModel {
  bool? success;
  String? message;
  List<Data>? data;

  ColorsModel({this.success, this.message, this.data});

  ColorsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
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
  dynamic hexCode;
  dynamic isActive;
  dynamic createdAt;

  Data({this.id, this.name, this.hexCode, this.isActive, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hexCode = json['hex_code'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['hex_code'] = hexCode;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    return data;
  }
}
