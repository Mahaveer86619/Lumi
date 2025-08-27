import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lumi/common/components/bottom_app_bar/bloc/navigation_bloc.dart';
import 'package:lumi/common/routes/app_routes.dart';
import 'package:lumi/core/theme/theme.dart';
import 'package:lumi/injection_container.dart' as di;

void main() async {
  await setup();
  runApp(const MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await di.registerDependencies();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => di.sl<NavigationBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'DiaryMate',
        theme: darkMode,
        debugShowCheckedModeBanner: false,
        initialRoute: '/register',
        routes: routes,
      ),
    );
  }
}
