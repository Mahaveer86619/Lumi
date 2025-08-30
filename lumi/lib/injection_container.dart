import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lumi/common/components/bottom_app_bar/bloc/navigation_bloc.dart';
import 'package:lumi/core/user/cubit/app_user_cubit.dart';
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
  //* Register AuthenticationBloc
  sl.registerSingleton<AppUserCubit>(
    AppUserCubit(
      logger: sl<Logger>(),
      secureStorage: sl<FlutterSecureStorage>(),
      sharedPreferences: sl<SharedPreferences>(),
    ),
  );

  //* Register NavigationBloc
  sl.registerLazySingleton<NavigationBloc>(
    () => NavigationBloc(),
  );
}

Future<void> dataSources() async {}

Future<void> repositories() async {}

Future<void> useCases() async {}

Future<void> blocs() async {}