import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/user_model.dart';

class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({required this.success, required this.message, this.data});
}

class ApiService {
  // Hàm đăng ký
  static Future<ApiResponse<UserModel>> register(String fullname, String email,
      String phone, String password, String confirmPassword) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.baseUrl + Constants.registerEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullname': fullname,
          'email': email,
          'phone': phone,
          'password': password,
          'confirm_password': confirmPassword,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return ApiResponse(
          success: true,
          message: responseData['message'],
          data: UserModel.fromJson(responseData['data']),
        );
      } else {
        return ApiResponse(
          success: false,
          message: responseData['message'] ?? 'Đăng ký thất bại',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Lỗi kết nối: $e',
      );
    }
  }

  // Hàm đăng nhập
  static Future<ApiResponse<UserModel>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.baseUrl + Constants.loginEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse(
          success: true,
          message: responseData['message'],
          data: UserModel.fromJson(responseData['data']),
        );
      } else {
        return ApiResponse(
          success: false,
          message: responseData['message'] ?? 'Đăng nhập thất bại',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Lỗi kết nối: $e',
      );
    }
  }

  // Hàm gửi OTP qua email
  static Future<ApiResponse<void>> sendOtpMail(String email) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.baseUrl + Constants.sendMailOtpEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse(
          success: true,
          message: responseData['message'],
        );
      } else {
        return ApiResponse(
          success: false,
          message: responseData['message'] ?? 'Gửi OTP thất bại',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Lỗi kết nối: $e',
      );
    }
  }

  // Hàm xác thực OTP
  static Future<ApiResponse<void>> verifyOtp(String otp, String email) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.baseUrl + Constants.verifyMailOtpEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'otp': otp,
          'email': email,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse(
          success: true,
          message: responseData['message'],
        );
      } else {
        return ApiResponse(
          success: false,
          message: responseData['message'] ?? 'Xác thực OTP thất bại',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Lỗi kết nối: $e',
      );
    }
  }

  // Hàm đặt lại mật khẩu
  static Future<ApiResponse<void>> resetPassword(
      String email, String newPassword, String confirmPassword) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.baseUrl + Constants.resetPasswordEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse(
          success: true,
          message: responseData['message'],
        );
      } else {
        return ApiResponse(
          success: false,
          message: responseData['message'] ?? 'Đặt lại mật khẩu thất bại',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Lỗi kết nối: $e',
      );
    }
  }
}
