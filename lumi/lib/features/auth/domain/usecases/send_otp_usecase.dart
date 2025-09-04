import 'package:lumi/core/utils/data_state.dart';
import 'package:lumi/core/utils/usecase.dart';
import 'package:lumi/features/auth/domain/entity/user_entity.dart';
import 'package:lumi/features/auth/domain/repository/auth_repository.dart';

class SendOTPUsecase implements Usecase<DataState<UserEntity>, SendOTPUsecaseParams> {
  final AuthRepository _authRepository;

  SendOTPUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<DataState<UserEntity>> execute({required SendOTPUsecaseParams params}) {
    return _authRepository.sendCodeForVerification(params.email, params.code);
  }
}

class SendOTPUsecaseParams {
  final String email;
  final String code;

  SendOTPUsecaseParams({required this.email, required this.code});
}
