import 'package:flutter/material.dart';
import 'package:lumi/common/components/text_field.dart';
import 'package:lumi/core/constants/app_strings.dart';
import 'package:lumi/core/layout/responsive_layout.dart';
import 'package:lumi/features/auth/presentation/widgets/auth_button.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final TextEditingController _codeController = TextEditingController();

  int _enterManually = 0;

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
    _showMessage('Email code sent');
  }

  void _toggleEnterManually() {
    setState(() {
      if (_enterManually == 2) {
        _enterManually = 0;
      } else {
        _enterManually++;
      }
    });
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
        if (_enterManually == 1) _buildManualBody(),
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
          AppStrings.codeEnterHeader,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.codeEnterDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(225),
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildManualBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MyFormTextField(
          hintText: '',
          controller: _codeController,
          keyboardType: TextInputType.number,
          label: 'Verification Code',
          keyboardAction: TextInputAction.done,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the code';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAuthButtons() {
    return AuthButton(
      onPressed: _toggleEnterManually,
      isGoogleAuth: false,
      label: (_enterManually == 0)
          ? AppStrings.enterCodeManually
          : (_enterManually == 1)
          ? AppStrings.codeVerifyButton
          : 'Continue',
    );
  }
}
