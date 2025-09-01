import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lumi/common/components/bottom_app_bar/bloc/navigation_bloc.dart';
import 'package:lumi/core/user/cubit/app_user_cubit.dart';
import 'package:lumi/core/user/data/auth_data.dart';
import 'package:lumi/features/auth/data/implementations/auth_repository_impl.dart';
import 'package:lumi/features/auth/data/sources/auth_source.dart';
import 'package:lumi/features/auth/domain/repository/auth_repository.dart';
import 'package:lumi/features/auth/domain/usecases/authenticate_usecase.dart';
import 'package:lumi/features/auth/domain/usecases/register_usecase.dart';
import 'package:lumi/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> registerDependencies() async {
  await other();
  await core();
  await dataSources();
  await repositories();
  await useCases();
  await blocs();
}

Future<void> other() async {
  //* Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  //* Register FlutterSecureStorage
  const secureStorage = FlutterSecureStorage();
  sl.registerSingleton<FlutterSecureStorage>(secureStorage);

  //* Register Logger
  sl.registerSingleton<Logger>(Logger());
}

Future<void> core() async {
  //* Auth Data
  sl.registerLazySingleton(
    () => AuthData(
      logger: sl<Logger>(),
    ),
  );

  //* Register AuthenticationBloc
  sl.registerSingleton<AppUserCubit>(
    AppUserCubit(
      logger: sl<Logger>(),
      secureStorage: sl<FlutterSecureStorage>(),
      sharedPreferences: sl<SharedPreferences>(),
      authData: sl<AuthData>(),
    ),
  );

  //* Register NavigationBloc
  sl.registerLazySingleton<NavigationBloc>(
    () => NavigationBloc(),
  );
}

Future<void> dataSources() async {
  sl.registerLazySingleton<AuthSource>(
    () => AuthSource(
      logger: sl<Logger>(),
    ),
  );
}

Future<void> repositories() async {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      logger: sl<Logger>(),
      authSource: sl<AuthSource>(),
      appUserCubit: sl<AppUserCubit>(),
    ),
  );
}

Future<void> useCases() async {
  sl.registerLazySingleton(() => RegisterUsecase(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton(() => AuthenticateUsecase(authRepository: sl<AuthRepository>()));
}

Future<void> blocs() async {
  sl.registerFactory(
    () => AuthBloc(
      appUserCubit: sl<AppUserCubit>(),
      logger: sl<Logger>(),
      authenticateUsecase: sl<AuthenticateUsecase>(),
      registerUsecase: sl<RegisterUsecase>(),
    ),
  );
}