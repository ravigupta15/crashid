class ForgetPasswordSendModel {
  String? email;

  ForgetPasswordSendModel({this.email});

  Map<String, dynamic> toMap() {
    return {'email': email?.trim()};
  }
}
