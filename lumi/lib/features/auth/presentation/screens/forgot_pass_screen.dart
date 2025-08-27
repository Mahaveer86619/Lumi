import 'package:flutter/material.dart';
import 'package:lumi/core/layout/responsive_layout.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileLayout: _mobileRegisterScreen(),
        desktopLayout: _desktopRegisterScreen(),
      ),
    );
  }

  Widget _mobileRegisterScreen() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Text(
          'Forgot Pass Screen',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }

  Widget _desktopRegisterScreen() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Text(
          'Forgot Pass Screen',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}