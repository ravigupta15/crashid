class ResetPasswordSendModel {
  String? password;
  String? confirmPassword;

  ResetPasswordSendModel({
    this.password,
    this.confirmPassword
  });

  Map<String, dynamic> toMap() {
    return {'email': password};
  }
}

