import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../widgets/splash_screen.dart';


final routes = <String, WidgetBuilder>{
  '/': (context) => const SplashScreen(),

  // auth
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const LoginScreen(),

  // Dashboard
  '/dashboard': (context) => const DashboardScreen(),
};