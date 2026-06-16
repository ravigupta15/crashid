import 'package:crashid/core/service/auth/social_auth_result.dart';

class SocialSignInSendModel {
  final String token;
  final String? email;
  final String? name;
  final String? providerId;
  final String? provider;

  SocialSignInSendModel({
    required this.token,
    this.email,
    this.name,
    this.providerId,
    this.provider,
  });

  factory SocialSignInSendModel.fromResult(SocialAuthResult result) {
    return SocialSignInSendModel(
      token: result.token,
      email: result.email,
      name: result.displayName,
      providerId: result.userId,
      provider: result.provider.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
     "provider": provider,
    "provider_id": providerId,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
    };
  }
}
