abstract class ApiUrls {
  ApiUrls._();

  static const baseUrl = "https://apicrid.forthprodigital.in/api/";

  static const loginUrl = '${baseUrl}user/auth/login';
  static const forgotPasswordUrl = '${baseUrl}user/auth/forgot-password';
  static const verifyOtpUrl = "${baseUrl}user/auth/verify-otp";
  static const resendOtpUrl = "${baseUrl}user/auth/resend-otp";
  static const resetPasswordUrl = "${baseUrl}user/auth/reset-password";
  static const personalRegistrationUrl = "${baseUrl}user/auth/register/personal";
  static const companyRegistrationUrl = "${baseUrl}user/auth/register/company";
}
