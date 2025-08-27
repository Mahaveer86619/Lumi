import 'package:flutter/material.dart';
import 'package:lumi/common/components/outlined_textfield.dart';
import 'package:lumi/core/layout/responsive_layout.dart';
import 'package:lumi/core/theme/pallete.dart';
import 'package:lumi/features/auth/presentation/widgets/google_auth_btn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildAuthForm(),
        ),
      ),
    );
  }

  Widget _desktopRegisterScreen() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Text(
          'Register Screen',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }

  Widget _buildAuthForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          "Create your account",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Join a network of visionaries and unlock premium design resources tailored for you.",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
        ),
        const SizedBox(height: 32),

        // Continue with Google Button
        GoogleAuthButton(onPressed: () {}),

        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          child: Divider(color: Pallete.neutral900, thickness: 1),
        ),

        const SizedBox(height: 12),

        // Full Name
        buildOutlinedTextField(
          labelText: "Full name",
          context: context,
          controller: _nameController,
        ),

        const SizedBox(height: 16),

        // Email
        buildOutlinedTextField(
          labelText: "Email address",
          context: context,
          controller: _emailController,
        ),

        const SizedBox(height: 16),

        // Password
        buildOutlinedTextField(
          labelText: "Password",
          context: context,
          controller: _passwordController,
          isPassword: true,
          showSuffixIcon: true,
        ),

        const SizedBox(height: 8),
        Text(
          "Password must be at least 8 characters, including a number and a special character.",
          style: TextStyle(color: Colors.grey[500], fontSize: 12),
        ),

        const SizedBox(height: 28),

        // Create Account Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDCE6C6), // light greenish
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text("Create account"),
          ),
        ),

        const SizedBox(height: 16),

        // Already have account
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: TextStyle(color: Colors.grey[400]),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                "Log In",
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 40),

        // Terms and Privacy
        Center(
          child: Text(
            "By signing up, you agree to our Terms and Privacy Policy.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ),
      ],
    );
  }
}
