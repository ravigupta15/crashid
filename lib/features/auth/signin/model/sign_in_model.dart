class SignInSendModel {
  String? email;
  String? password;
  bool acceptTerms;

  SignInSendModel({this.email, this.password, this.acceptTerms = false});

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password
    };
  }
}
