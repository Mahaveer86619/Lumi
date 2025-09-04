import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:lumi/common/endpoints/api_endpoints.dart';
import 'package:lumi/core/utils/data_state.dart';

class AuthSource {
  final Logger logger;

  AuthSource({required this.logger});

  Future<DataState<Map<String, dynamic>>> authenticateWithEmail(
    String email,
    String password,
  ) async {
    logger.i("Authenticating with email: $email");

    try {
      final reqBody = jsonEncode({'email': email, 'password': password});

      final resp = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {'Content-Type': 'application/json'},
        body: reqBody,
      );

      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        return DataSuccess(data, 'Authentication successful');
      } else {
        return DataFailure('Authentication failed', resp.statusCode);
      }
    } catch (e) {
      logger.e("Error during email authentication: $e");
      return DataFailure("Authentication Failure", -1);
    }
  }

  Future<DataState<Map<String, dynamic>>> registerWithEmail(
    String email,
    String fullName,
    String password,
  ) async {
    logger.i("Registering with email: $email");

    try {
      final reqBody = jsonEncode({
        'email': email,
        'full_name': fullName,
        'password': password,
      });

      final resp = await http.post(
        Uri.parse(ApiEndpoints.register),
        headers: {'Content-Type': 'application/json'},
        body: reqBody,
      );

      if (resp.statusCode == 201) {
        final data = jsonDecode(resp.body);
        return DataSuccess(data, 'Registration successful');
      } else {
        return DataFailure('Registration failed', resp.statusCode);
      }
    } catch (e) {
      logger.e("Error during email registration: $e");
      return DataFailure("Registration failure", -1);
    }
  }

  Future<DataState<Map<String, dynamic>>> sendEmailForVerification(
    String email,
  ) async {
    logger.i("Sending email to: $email");

    try {
      final reqBody = jsonEncode({'email': email});

      final resp = await http.post(
        Uri.parse(ApiEndpoints.sendEmail),
        headers: {'Content-Type': 'application/json'},
        body: reqBody,
      );

      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        return DataSuccess(data, 'Email sent successfully');
      } else {
        return DataFailure('Failed to send email', resp.statusCode);
      }
    } catch (e) {
      logger.e("Error during sending email: $e");
      return DataFailure('Error sending email', -1);
    }
  }

  Future<DataState<Map<String, dynamic>>> sendCodeForVerification(
    String email,
    String code,
  ) async {
    logger.i("Sending otp with: $email");

    try {
      final reqBody = jsonEncode({'email': email, 'code': code});

      final resp = await http.post(
        Uri.parse(ApiEndpoints.verifyOTP),
        headers: {'Content-Type': 'application/json'},
        body: reqBody,
      );

      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        return DataSuccess(data, 'OTP verified successfully');
      } else {
        return DataFailure('Failed to verify otp', resp.statusCode);
      }
    } catch (e) {
      logger.e("Error during sending email: $e");
      return DataFailure('Error sending email', -1);
    }
  }
}
