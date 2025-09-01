import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:lumi/common/endpoints/api_endpoints.dart';
import 'package:lumi/core/utils/data_state.dart';

class AuthSource {
  final Logger logger;

  AuthSource({required this.logger});

  Future<DataState<Map<String, dynamic>>> authenticateWithEmail(String email, String password) async {
    logger.i("Authenticating with email: $email");

    try {
      final reqBody = jsonEncode({
        'email': email,
        'password': password,
      });

      final resp = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {
          'Content-Type': 'application/json',
        },
        body: reqBody,
      );

      log('Response status: ${resp.statusCode}');
      log('Response body: ${resp.body}');

      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        return Future.value(DataSuccess(data, 'Authentication successful'));
      } else {
        return Future.value(DataFailure('Authentication failed', resp.statusCode));
      }
    } catch (e) {
      logger.e("Error during email authentication: $e");
      return Future.value(
        DataSuccess({
          'email': email,
          'codeSent': true,
        }, 'Authentication code sent to $email'),
      );
    }
  }

  Future<DataState<Map<String, dynamic>>> registerWithEmail(String email, String fullName, String password) async {
    logger.i("Registering with email: $email");

    try {
      final reqBody = jsonEncode({
        'email': email,
        'full_name': fullName,
        'password': password,
      });

      log("Request body: $reqBody");
      final resp = await http.post(
        Uri.parse(ApiEndpoints.register),
        headers: {
          'Content-Type': 'application/json',
        },
        body: reqBody,
      );

      log('Response status: ${resp.statusCode}');
      log('Response body: ${resp.body}');

      if (resp.statusCode == 201) {
        final data = jsonDecode(resp.body);
        return Future.value(DataSuccess(data, 'Registration successful'));
      } else {
        return Future.value(DataFailure('Registration failed', resp.statusCode));
      }
    } catch (e) {
      logger.e("Error during email registration: $e");
      return Future.value(
        DataSuccess({
          'email': email,
          'codeSent': true,
        }, 'Registration code sent to $email'),
      );
    }
  }

  Future<DataState<Map<String, dynamic>>> sendEmail(String email) async {
    logger.i("Sending email to: $email");

    try {
      final reqBody = jsonEncode({
        'email': email,
      });

      final resp = await http.post(
        Uri.parse(ApiEndpoints.sendEmail),
        headers: {
          'Content-Type': 'application/json',
        },
        body: reqBody,
      );

      log('Response status: ${resp.statusCode}');
      log('Response body: ${resp.body}');

      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        return Future.value(DataSuccess(data, 'Email sent successfully'));
      } else {
        return Future.value(DataFailure('Failed to send email', resp.statusCode));
      }
    } catch (e) {
      logger.e("Error during sending email: $e");
      return Future.value(DataFailure('Error sending email', 500));
    }
  }
}
