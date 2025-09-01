import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:lumi/core/user/cubit/app_user_cubit.dart';
import 'package:lumi/core/utils/data_state.dart';
import 'package:lumi/features/auth/domain/usecases/authenticate_usecase.dart';
import 'package:lumi/features/auth/domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppUserCubit _appUserCubit;
  final Logger _logger;

  final AuthenticateUsecase _authenticateUsecase;
  final RegisterUsecase _registerUsecase;

  AuthBloc({
    required AppUserCubit appUserCubit,
    required Logger logger,
    required AuthenticateUsecase authenticateUsecase,
    required RegisterUsecase registerUsecase,
  }) : _appUserCubit = appUserCubit,
       _logger = logger,
       _authenticateUsecase = authenticateUsecase,
       _registerUsecase = registerUsecase,
       super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      try {
        emit(const AuthLoading());
        final resp = await _registerUsecase.execute(
          params: RegisterUsecaseParams(
            fullName: event.fullName,
            email: event.email,
            password: event.password,
          ),
        );

        if (resp is DataFailure) {
          _logger.e(resp.message!);
          emit(AuthError(resp.message!));
          return;
        }

        if (resp.data == null) {
          _logger.e('Something went wrong');
          emit(const AuthError('Something went wrong'));
          return;
        }

        log("Resp: ${resp.data}");
        log("message: ${resp.message!}");

        // emit success
        emit(const Authenticated());
      } catch (e) {
        _logger.e(e);
        emit(const AuthError('Something went wrong'));
      }
    });
  }
}
