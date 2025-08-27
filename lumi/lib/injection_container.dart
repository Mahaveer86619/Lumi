import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lumi/common/components/bottom_app_bar/bloc/navigation_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> registerDependencies() async {
  other();
  core();
  dataSources();
  repositories();
  useCases();
  blocs();
}

void other() async {
  //* Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  //* Register FlutterSecureStorage
  const secureStorage = FlutterSecureStorage();
  sl.registerSingleton<FlutterSecureStorage>(secureStorage);

  //* Register Logger
  sl.registerSingleton<Logger>(Logger());
}

void core() {
  //* Register NavigationBloc
  sl.registerLazySingleton<NavigationBloc>(
    () => NavigationBloc(),
  );
}

void dataSources() {}

void repositories() {}

void useCases() {}

void blocs() {}