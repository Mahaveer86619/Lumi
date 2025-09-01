
import 'package:lumi/core/utils/data_state.dart';
import 'package:lumi/core/utils/usecase.dart';
import 'package:lumi/features/auth/domain/entity/user_entity.dart';
import 'package:lumi/features/auth/domain/repository/auth_repository.dart';

class AuthenticateUsecase implements Usecase<DataState<UserEntity>, AuthenticateUsecaseParams> {
  final AuthRepository _authRepository;

  AuthenticateUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<DataState<UserEntity>> execute({required AuthenticateUsecaseParams params}) {
    return _authRepository.authenticateWithEmail(params.email, params.password);
  }
}

class AuthenticateUsecaseParams {
  final String email;
  final String password;

  AuthenticateUsecaseParams({
    required this.email,
    required this.password,
  });
}