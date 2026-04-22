class ResetPasswordSendModel {
  String? password;
  String? confirmPassword;
  String? token;

  ResetPasswordSendModel({
    this.password,
    this.confirmPassword,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'new_password': password,
      'confirm_password': confirmPassword,
      'reset_token': token,
    };
  }
}

