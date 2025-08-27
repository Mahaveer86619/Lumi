import 'package:flutter/material.dart';
import 'package:lumi/common/components/splash_screen.dart';
import 'package:lumi/features/auth/presentation/screens/authentication_screen.dart';
import 'package:lumi/features/auth/presentation/screens/forgot_pass_screen.dart';
import 'package:lumi/features/auth/presentation/screens/register_screen.dart';

final routes = <String, WidgetBuilder>{
  '/': (context) => const SplashScreen(),

  // // auth
  '/authenticate': (context) => const AuthenticationScreen(),
  '/register': (context) => const RegisterScreen(),
  '/forgot-password': (context) => const ForgotPassScreen(),

  // // Dashboard
  // '/dashboard': (context) => const DashboardScreen(),
};