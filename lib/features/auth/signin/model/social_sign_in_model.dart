import 'package:crashid/core/service/auth/social_auth_result.dart';

class SocialSignInSendModel {
  final String token;
  final String? email;
  final String? name;
  final String? providerId;

  SocialSignInSendModel({
    required this.token,
    this.email,
    this.name,
    this.providerId,
  });

  factory SocialSignInSendModel.fromResult(SocialAuthResult result) {
    return SocialSignInSendModel(
      token: result.token,
      email: result.email,
      name: result.displayName,
      providerId: result.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
     "provider": "google",
    "provider_id": providerId,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
    };
  }
}
