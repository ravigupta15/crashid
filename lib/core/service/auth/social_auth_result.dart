enum SocialAuthProvider { google, facebook }

class SocialAuthResult {
  final SocialAuthProvider provider;
  final String token;
  final String? email;
  final String? displayName;
  final String? userId;

  const SocialAuthResult({
    required this.provider,
    required this.token,
    this.email,
    this.displayName,
    this.userId,
  });
}
