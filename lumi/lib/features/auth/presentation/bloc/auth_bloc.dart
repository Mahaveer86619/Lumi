import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:lumi/core/user/cubit/app_user_cubit.dart';
import 'package:lumi/core/user/models/app_user.dart';
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
    on<SignUpEvent>(onSignUpEvent);
    on<SignInEvent>(onSignInEvent);
  }

  Future<void> onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
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

      // emit success
      emit(const Authenticated());

      AppUser appUser;
      if (resp.data != null) {
        appUser = AppUser(
          id: resp.data!.id,
          fullName: resp.data!.fullName,
          email: resp.data!.email,
          isVerified: resp.data!.isVerified,
          profilePicture: resp.data!.profilePicture,
          authType: resp.data!.authType,
        );
      } else {
        _logger.i("Response data is null");
        appUser = AppUser(
          id: "",
          fullName: "",
          email: "",
          isVerified: "",
          profilePicture: "",
          authType: "",
        );
      }
      await _appUserCubit.authenticateUser(appUser);
    } catch (e) {
      _logger.e(e);
      emit(const AuthError('Something went wrong'));
    }
  }

  Future<void> onSignInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const AuthLoading());
      final resp = await _authenticateUsecase.execute(
        params: AuthenticateUsecaseParams(
          email: event.email,
          password: event.password,
        ),
      );

      if (resp is DataFailure) {
        _logger.e(resp.message!);
        emit(AuthError(resp.message!));
        return;
      }

      // emit success
      emit(const Authenticated());

      AppUser appUser;
      if (resp.data != null) {
        appUser = AppUser(
          id: resp.data!.id,
          fullName: resp.data!.fullName,
          email: resp.data!.email,
          isVerified: resp.data!.isVerified,
          profilePicture: resp.data!.profilePicture,
          authType: resp.data!.authType,
        );
      } else {
        _logger.i("Response data is null");
        appUser = AppUser(
          id: "",
          fullName: "",
          email: "",
          isVerified: "",
          profilePicture: "",
          authType: "",
        );
      }
      await _appUserCubit.authenticateUser(appUser);
    } catch (e) {
      _logger.e(e);
      emit(const AuthError('Something went wrong'));
    }
  }
}
