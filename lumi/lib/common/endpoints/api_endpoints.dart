import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String baseUrl = dotenv.env['BASE_URL'] ?? 'http://localhost:8000';

  static String login = '$baseUrl/login';
  static String register = '$baseUrl/register';
  static String sendEmail = '$baseUrl/verify-email';
  static String verifyOTP = '$baseUrl/verify-otp';

  static String refreshToken = '$baseUrl/refresh';

  static String getAllUsers = '$baseUrl/api/users';
  static String getUserById = '$baseUrl/api/users';
  static String getUserByEmail = '$baseUrl/api/users';
  static String updateUser = '$baseUrl/api/users';
  static String deleteUser = '$baseUrl/api/users';

}