class SignInResponseModel {
  bool? success;
  String? message;
  Data? data;

  SignInResponseModel({this.success, this.message, this.data});

  SignInResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? accessToken;
  String? refreshToken;
  bool? profileComplete;

  Data({this.accessToken, this.refreshToken, this.profileComplete});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    profileComplete = json['profile_complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['profile_complete'] = profileComplete;
    return data;
  }
}
