import 'package:flutter/material.dart';
import 'package:lumi/core/localization/app_strings.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleGoogleAuth() {
    // Handle Google authentication logic
  }

  void handleEmailAuth() {
    // Handle email authentication logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        Spacer(),
        _buildAuthButtons(),
        SizedBox(height: 8),
        _buildTermsAndConditions(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.appheader,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          AppStrings.appDescription,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildAuthButtons() {
    return Column(
      children: [
        AuthButton(onPressed: handleGoogleAuth, isGoogleAuth: true),
        SizedBox(height: 16),
        AuthButton(
          onPressed: handleEmailAuth,
          isGoogleAuth: false,
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            AppStrings.termsAndConditions,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
