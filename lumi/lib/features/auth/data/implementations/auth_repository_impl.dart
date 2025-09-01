import 'package:logger/web.dart';
import 'package:lumi/core/constants/app_constants.dart';
import 'package:lumi/core/user/cubit/app_user_cubit.dart';
import 'package:lumi/core/user/models/app_user.dart';
import 'package:lumi/core/utils/data_state.dart';
import 'package:lumi/features/auth/data/models/user_model.dart';
import 'package:lumi/features/auth/data/sources/auth_source.dart';
import 'package:lumi/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Logger _logger;
  final AuthSource _authSource;
  final AppUserCubit _appUserCubit;

  AuthRepositoryImpl({
    required Logger logger,
    required AuthSource authSource,
    required AppUserCubit appUserCubit,
  })  : _logger = logger,
        _authSource = authSource,
        _appUserCubit = appUserCubit;

  @override
  Future<DataState<UserModel>> authenticateWithEmail(
    String email,
    String password,
  ) async {
    try {
      final resp = await _authSource.authenticateWithEmail(email, password);

      if (resp is DataFailure) {
        return DataFailure(resp.message!, resp.statusCode!);
      }

      final userModel = UserModel.fromJson(resp.data!);


      final user = userModel.toEntity();
      _appUserCubit.authenticateUser(
        AppUser(
          id: user.id,
          fullName: user.fullName,
          email: user.email,
          profilePicture: (user.profilePicture == "") ? AppConstants.defaultAvatarUrl : user.profilePicture,
          authType: (user.authType == "") ? "" : user.authType,
        ),
      );

      final token = userModel.token;
      final refreshToken = userModel.refreshToken;
      _appUserCubit.saveTokens(accessToken: token, refreshToken: refreshToken);

      return DataSuccess(userModel, resp.message!);
    } catch (e) {
      return DataFailure("Authentication failed", 500);
    }
  }

  @override
  Future<DataState<UserModel>> registerWithEmail(
    String email,
    String fullName,
    String password,
  ) async {
    try {
      final resp = await _authSource.registerWithEmail(
        email,
        fullName,
        password,
      );

      if (resp is DataFailure) {
        return DataFailure(resp.message!, resp.statusCode!);
      }

      final userModel = UserModel.fromJson(resp.data!);
      return DataSuccess(userModel, resp.message!);
    } catch (e) {
      return DataFailure("Registration failed", 500);
    }
  }

  @override
  Future<DataState<UserModel>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<DataState<UserModel>> refreshToken(String refreshToken) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }
}
