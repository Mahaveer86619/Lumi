import 'package:flutter/material.dart';

void navigateToScreen(
  BuildContext context,
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

// Helper for showing a SnackBar (toast)
void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
