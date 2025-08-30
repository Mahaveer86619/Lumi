import 'package:flutter/material.dart';
import 'package:lumi/features/auth/presentation/screens/app_start.dart';
import 'package:lumi/features/auth/presentation/screens/auth_screen.dart';
import 'package:lumi/features/auth/presentation/screens/code_screen.dart';
import 'package:lumi/features/auth/presentation/screens/email_screen.dart';

final routes = <String, WidgetBuilder>{
  '/start': (context) => const AppStart(),

  // // auth
  '/auth': (context) => const AuthScreen(),
  '/email-auth': (context) => const EmailScreen(),
  '/email-code': (context) => const CodeScreen(),

  // // Dashboard
  // '/dashboard': (context) => const DashboardScreen(),
};