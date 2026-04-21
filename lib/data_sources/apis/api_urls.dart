abstract class ApiUrls {
  ApiUrls._();

  static const baseUrl = "https://apicrid.forthprodigital.in/api/";

  static const loginUrl = 'user/auth/login';
  static const forgotPasswordUrl = 'user/auth/forgot-password';
  static const verifyOtpUrl = "user/auth/verify-otp";
  static const resendOtpUrl = "user/auth/resend-otp";
  static const resetPasswordUrl = "";
  static const personalRegistrationUrl = "auth/register/personal";
}
