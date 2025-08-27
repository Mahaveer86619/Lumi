import 'package:flutter/material.dart';
import 'package:lumi/core/theme/pallete.dart';

TextField buildOutlinedTextField({
  required String labelText,
  required TextEditingController controller,
  required BuildContext context,
  bool isPassword = false,
  bool showSuffixIcon = false,
}) {
  final ThemeData theme = Theme.of(context);
  final ColorScheme colorScheme = theme.colorScheme;

  return TextField(
    controller: controller,
    obscureText: isPassword,
    cursorColor: colorScheme.onSurface,
    style: TextStyle(color: colorScheme.onSurface),
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Pallete.neutral700),
      filled: true,
      fillColor: colorScheme.surface.withAlpha(100),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Pallete.neutral700, width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Pallete.neutral500, width: 0.8),
        borderRadius: BorderRadius.circular(10.0),
      ),
      suffixIcon: showSuffixIcon
          ? Icon(Icons.visibility, color: Pallete.neutral700)
          : null,
    ),
  );
}
