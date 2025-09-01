import 'package:lumi/core/utils/data_state.dart';
import 'package:lumi/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<DataState<UserEntity>> authenticateWithEmail(String email, String password);
  Future<DataState<UserEntity>> registerWithEmail(String email, String fullName, String password);
  Future<void> logout();
  Future<DataState<UserEntity>> getCurrentUser();
  Future<DataState<UserEntity>> refreshToken(String refreshToken);
}