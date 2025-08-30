import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lumi/core/constants/app_strings.dart';

class AuthButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isGoogleAuth;
  final String label;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.isGoogleAuth,
    this.label = "Continue",
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: _sizedBoxBtn()
          .animate(target: _isPressed ? 1 : 0)
          .scaleXY(
            begin: 1.0,
            end: 0.95, // shrink effect
            duration: 150.ms,
            curve: Curves.easeOut,
          ),
    );
  }

  Widget _sizedBoxBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: widget.isGoogleAuth
            ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 8)
            : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.isGoogleAuth)
            Image.asset('assets/images/google.png', height: 18.0),
          if (widget.isGoogleAuth) const SizedBox(width: 16.0),
          const SizedBox(height: 24.0),
          Text(
            widget.isGoogleAuth
                ? AppStrings.googleAuthButton
                : widget.label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: widget.isGoogleAuth
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
