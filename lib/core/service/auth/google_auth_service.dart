import 'package:crashid/core/service/auth/social_auth_result.dart';
import 'package:crashid/res/app_constant.dart';
import 'package:crashid/utils/extensions/extension_string.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  GoogleAuthService._();

  static final GoogleAuthService instance = GoogleAuthService._();

  static GoogleAuthService get shared => instance;

  late final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: const ['email', 'profile'],
    serverClientId: AppConstant.googleWebClientId.isNotNullOrNotEmpty
        ? AppConstant.googleWebClientId
        : null,
  );

  Future<SocialAuthResult?> signIn() async {
    final account = await _googleSignIn.signIn();
    if (account == null) return null;

    final auth = await account.authentication;
    final idToken = auth.idToken;
    print('Google ID Token: $idToken');
    print('Google Access Token: ${auth.accessToken}');
    if (idToken == null) {
      throw Exception('Failed to get Google ID token. Check web client ID config.');
    }

    return SocialAuthResult(
      provider: SocialAuthProvider.google,
      token: idToken,
      email: account.email,
      displayName: account.displayName,
      userId: account.id,
    );
  }

  Future<void> signOut() => _googleSignIn.signOut();

  Future<bool> isSignedIn() => _googleSignIn.isSignedIn();
}
