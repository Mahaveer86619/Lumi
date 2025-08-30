import 'package:logger/web.dart';
import 'package:lumi/core/utils/data_state.dart';

class AuthSource {
  final Logger logger;

  AuthSource({required this.logger});

  Future<DataState<Map<String, dynamic>>> authenticateWithEmail(String email) {
    logger.i("Authenticating with email: $email");

    try {
      // Simulate network call
      Future.delayed(const Duration(seconds: 2));

      // Simulate success response
      return Future.value(
        DataSuccess({
          'email': email,
          'codeSent': true,
        }, 'Authentication code sent to $email'),
      );
    } catch (e) {
      logger.e("Error during email authentication: $e");
      return Future.value(
        DataFailure('Failed to send authentication code', 500),
      );
    }
  }
}
