import 'package:flutter/material.dart';
import 'package:lumi/common/components/text_field.dart';
import 'package:lumi/core/constants/app_strings.dart';
import 'package:lumi/core/layout/responsive_layout.dart';
import 'package:lumi/features/auth/presentation/widgets/auth_button.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();

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

  void handleContinue() {
    // Handle email authentication logic
    _changeScreen('/email-code', isReplacement: false);
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
          'Email Screen',
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
        const SizedBox(height: 24),
        _buildEmailInput(),
        const Spacer(),
        _buildAuthButtons(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          AppStrings.emailAuthHeader,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.emailAuthDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(225),
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailInput() {
    return MyFormTextField(
      hintText: 'example@email.com',
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      label: 'Email',
      keyboardAction: TextInputAction.done,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }

  Widget _buildAuthButtons() {
    return Column(
      children: [AuthButton(onPressed: handleContinue, isGoogleAuth: false)],
    );
  }
}
