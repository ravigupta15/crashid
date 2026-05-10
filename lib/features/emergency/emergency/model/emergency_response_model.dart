class EmergencyResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  EmergencyResponseModel({this.success, this.message, this.data});

  EmergencyResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data =  <Data>[];
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
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic friendUserId;
  dynamic plateNumber;
  dynamic category;
  dynamic createdAt;
  dynamic friendEmail;
  dynamic friendProfileImage;
  dynamic firstName;
  dynamic lastName;

  Data(
      {this.id,
      this.friendUserId,
      this.plateNumber,
      this.category,
      this.createdAt,
      this.friendEmail,
      this.friendProfileImage,
      this.firstName,
      this.lastName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    friendUserId = json['friend_user_id'];
    plateNumber = json['plate_number'];
    category = json['category'];
    createdAt = json['created_at'];
    friendEmail = json['friend_email'];
    friendProfileImage = json['friend_profile_image'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['friend_user_id'] = friendUserId;
    data['plate_number'] = plateNumber;
    data['category'] = category;
    data['created_at'] = createdAt;
    data['friend_email'] = friendEmail;
    data['friend_profile_image'] = friendProfileImage;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
