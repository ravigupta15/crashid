class OtpSendModel {
  String? otp;
  String? id;
  String? type;

  OtpSendModel({this.otp, this.id, this.type});

  Map<String, dynamic> toMap() {
    return {
      "otp":otp,
      "user_id": id,
      "type": type
    };
  }
  
  Map<String, dynamic> toResendMap() {
    return {
      "user_id": id,
      "type": type
    };
  }
}