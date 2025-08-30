import 'package:flutter/material.dart';
import 'package:lumi/core/localization/app_strings.dart';
import 'package:lumi/core/theme/pallete.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isGoogleAuth;
  const AuthButton({super.key, required this.onPressed, this.isGoogleAuth = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: isGoogleAuth ? _googleLogo() : _emailLogo(),
        label: Text(
          isGoogleAuth ? AppStrings.continueWithGoogle : AppStrings.continueWithEmail,
          style: TextStyle(color: Pallete.neutral300),
          selectionColor: Theme.of(context).colorScheme.primary,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey[700]!),
          ),
        ),
      ),
    );
  }

  Widget _googleLogo() {
    return SizedBox(
      height: 18,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Image.asset('assets/images/google.png', fit: BoxFit.cover),
      ),
    );
  }

  Widget _emailLogo() {
    return Icon(
      Icons.email_outlined,
      color: Pallete.neutral300,
    );
  }
}
