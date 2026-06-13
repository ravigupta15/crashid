import 'package:crashid/core/service/auth/social_auth_result.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthService {
  FacebookAuthService._();

  static final FacebookAuthService instance = FacebookAuthService._();

  static FacebookAuthService get shared => instance;

  Future<SocialAuthResult?> signIn() async {
    final result = await FacebookAuth.instance.login(
      permissions: const ['email', 'public_profile'],
    );
    print('Facebook login result: ${result.status}, message: ${result.message}');
    if (result.status == LoginStatus.cancelled) return null;
    if (result.status != LoginStatus.success) {
      throw Exception(result.message ?? 'Facebook login failed');
    }

    final accessToken = result.accessToken?.tokenString;
    if (accessToken == null) {
      throw Exception('Failed to get Facebook access token');
    }

    final userData = await FacebookAuth.instance.getUserData(
      fields: 'name,email',
    );

    return SocialAuthResult(
      provider: SocialAuthProvider.facebook,
      token: accessToken,
      email: userData['email'] as String?,
      displayName: userData['name'] as String?,
      userId: userData['id'] as String?,
    );
  }

  Future<void> signOut() => FacebookAuth.instance.logOut();

  Future<AccessToken?> get accessToken => FacebookAuth.instance.accessToken;
}
