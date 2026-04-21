class OtpSendModel {
  String? otp;

  OtpSendModel({this.otp});

  Map<String, dynamic> toMap() {
    return {
      "otp":otp
    };
  }
}