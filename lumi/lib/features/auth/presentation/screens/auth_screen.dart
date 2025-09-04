import 'package:flutter/material.dart';
import 'package:lumi/core/constants/app_strings.dart';
import 'package:lumi/core/layout/responsive_layout.dart';
import 'package:lumi/features/auth/presentation/widgets/auth_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _changeScreen(
    String routeName, {
    Map<String, dynamic>? arguments,
    bool isReplacement = false,
  }) {
    if (isReplacement) {
      Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
    } else {
      Navigator.pushNamed(context, routeName, arguments: arguments);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void handleGoogleAuth() {
    // Handle Google authentication logic
    _showMessage(AppStrings.googleAuthSuccessMessage);
  }

  void handleEmailAuth() {
    // Handle email authentication logic
    _changeScreen('/sign-in', isReplacement: false);
  }

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
      body: Padding(padding: const EdgeInsets.all(16.0), child: _buildBody()),
    );
  }

  Widget _desktopRegisterScreen() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Text(
          'Authentication Screen',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const Spacer(),
        _buildAuthButtons(),
        const SizedBox(height: 24),
        _buildTermsAndConditions(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          AppStrings.welcomeHeader,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(225),
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthButtons() {
    return Column(
      children: [
        AuthButton(onPressed: handleGoogleAuth, isGoogleAuth: true),
        const SizedBox(height: 16),
        AuthButton(
          onPressed: handleEmailAuth,
          isGoogleAuth: false,
          label: AppStrings.emailAuthButton,
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    return Text(
      AppStrings.termsAndConditions,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 128),
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }
}
