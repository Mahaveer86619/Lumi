import 'package:lumi/core/utils/data_state.dart';
import 'package:lumi/core/utils/usecase.dart';
import 'package:lumi/features/auth/domain/repository/auth_repository.dart';

class SendEmailUsecase
    implements Usecase<DataState<void>, SendEmailUsecaseParams> {
  final AuthRepository _authRepository;

  SendEmailUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<DataState<void>> execute({required SendEmailUsecaseParams params}) {
    return _authRepository.sendEmailForVerification(params.email);
  }
}

class SendEmailUsecaseParams {
  final String email;

  SendEmailUsecaseParams({required this.email});
}
