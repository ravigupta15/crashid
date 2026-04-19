class SignInSendModel {
  String? email;
  String? password;
  bool acceptTerms;

  SignInSendModel({this.email, this.password, this.acceptTerms = false});
}
