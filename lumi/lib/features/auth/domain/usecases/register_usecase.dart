import 'package:lumi/core/utils/data_state.dart';
import 'package:lumi/core/utils/usecase.dart';
import 'package:lumi/features/auth/domain/entity/user_entity.dart';
import 'package:lumi/features/auth/domain/repository/auth_repository.dart';

class RegisterUsecase
    implements Usecase<DataState<UserEntity>, RegisterUsecaseParams> {
  final AuthRepository _authRepository;

  RegisterUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<DataState<UserEntity>> execute({
    required RegisterUsecaseParams params,
  }) {
    return _authRepository.registerWithEmail(
      params.email,
      params.fullName,
      params.password,
    );
  }
}

class RegisterUsecaseParams {
  final String email;
  final String fullName;
  final String password;

  RegisterUsecaseParams({
    required this.email,
    required this.fullName,
    required this.password,
  });
}
