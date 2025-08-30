import 'package:flutter/material.dart';
import 'package:lumi/common/components/splash_screen.dart';
import 'package:lumi/features/auth/presentation/screens/auth_screen.dart';
import 'package:lumi/features/auth/presentation/screens/forgot_pass_screen.dart';

final routes = <String, WidgetBuilder>{
  '/': (context) => const SplashScreen(),

  // // auth
  '/email_auth': (context) => const AuthScreen(),
  '/forgot-password': (context) => const ForgotPassScreen(),

  // // Dashboard
  // '/dashboard': (context) => const DashboardScreen(),
};