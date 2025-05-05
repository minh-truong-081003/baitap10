class Constants {
  // API Base URL
  static const String baseUrl = 'https://89ab-2405-4802-9154-7ef0-5df4-4b64-4741-2b18.ngrok-free.app/api'; // Sử dụng IP này cho emulator Android
  
  // API Endpoints
  static const String registerEndpoint = '/auth/register';
  static const String loginEndpoint = '/auth/login';
  static const String sendMailOtpEndpoint = '/auth/sendMail';
  static const String verifyMailOtpEndpoint = '/auth/verifyMailOtp';
  static const String resetPasswordEndpoint = '/auth/resetPasswordFromMail';
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userIdKey = 'user_id';
  static const String userDataKey = 'user_data';
} 