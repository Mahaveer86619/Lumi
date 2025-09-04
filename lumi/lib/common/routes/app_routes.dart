import 'package:flutter/material.dart';
import 'package:lumi/core/user/auth_gate.dart';
import 'package:lumi/features/auth/presentation/screens/auth_screen.dart';
import 'package:lumi/features/auth/presentation/screens/code_screen.dart';
import 'package:lumi/features/auth/presentation/screens/email_screen.dart';
import 'package:lumi/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:lumi/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:lumi/features/auth/presentation/screens/test_screen.dart';
import 'package:lumi/features/dashboard/presentation/screens/home_screen.dart';

final routes = <String, WidgetBuilder>{
  '/auth-gate': (context) => const AuthGate(),

  // test
  '/test': (context) => const TestScreen(),

  // auth
  '/auth': (context) => const AuthScreen(),
  '/sign-in': (context) => const SignInScreen(),
  '/sign-up': (context) => const SignUpScreen(),

  '/email-auth': (context) => const EmailScreen(),
  '/email-code': (context) => const CodeScreen(),

  // // Dashboard
  '/home': (context) => const HomeScreen(),
};