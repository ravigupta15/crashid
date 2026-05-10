class SearchUserResponseModel {
  bool? success;
  String? message;
  List<UserModel>? data;

  SearchUserResponseModel({this.success, this.message, this.data});

  SearchUserResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserModel>[];
      json['data'].forEach((v) {
        data?.add(UserModel.fromJson(v));
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

class UserModel {
  dynamic userId;
  dynamic accountType;
  dynamic displayName;
  dynamic profileImageUrl;
  dynamic matchedVia;
  dynamic plateNumber;
  dynamic vehicleId;
  dynamic email;

  UserModel(
      {this.userId,
      this.accountType,
      this.displayName,
      this.profileImageUrl,
      this.matchedVia,
      this.plateNumber,
      this.vehicleId,
      this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    accountType = json['account_type'];
    displayName = json['display_name'];
    profileImageUrl = json['profile_image_url'];
    matchedVia = json['matched_via'];
    plateNumber = json['plate_number'];
    vehicleId = json['vehicle_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['user_id'] = userId;
    data['account_type'] = accountType;
    data['display_name'] = displayName;
    data['profile_image_url'] = profileImageUrl;
    data['matched_via'] = matchedVia;
    data['plate_number'] = plateNumber;
    data['vehicle_id'] = vehicleId;
    data['email'] = email;
    return data;
  }
}
