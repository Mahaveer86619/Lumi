import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String baseUrl = dotenv.env['BASE_URL'] ?? 'http://localhost:8000';

  static String login = '$baseUrl/auth/login';
  static String register = '$baseUrl/auth/register';

  static String refreshToken = '$baseUrl/auth/refresh';
}