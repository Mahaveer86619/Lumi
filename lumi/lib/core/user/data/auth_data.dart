import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:lumi/common/endpoints/api_endpoints.dart';
import 'package:lumi/core/utils/data_state.dart';

class AuthData {
  final Logger logger;

  AuthData({required this.logger});

  Future<DataState<Map<String, dynamic>>> refreshTokens(
    String refreshToken,
  ) async {
    logger.i("Refreshing tokens with refresh token: $refreshToken");

    try {
      final body = {'refresh_token': refreshToken};

      final resp = await http.post(
        Uri.parse(ApiEndpoints.refreshToken),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (resp.statusCode != 200) {
        logger.e("Failed to refresh tokens: ${resp.body}");
        return DataFailure("Failed to refresh tokens", resp.statusCode);
      }

      final responseBody = jsonDecode(resp.body);
      return Future.value(DataSuccess(responseBody, "Tokens refreshed successfully"));
    } catch (e) {
      logger.e("Error during token refresh: $e");
      return Future.value(DataFailure('Failed to refresh tokens', 500));
    }
  }
}
