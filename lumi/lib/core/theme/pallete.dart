import 'package:flutter/material.dart';

class Pallete {
  // Supabase Core Colors
  static const Color supabaseGreen = Color(0xFF24A28B); // Core Supabase Green
  static const Color supabaseTurquoise = Color(0xFF26B09B); // A slightly different green used in gradients
  static const Color supabaseDarkGreen = Color(0xFF062D24); // Darker green for backgrounds/surfaces
  static const Color supabasedarkestGreen = Color(0xFF0C1318);
  
  // Grays for text and surfaces
  static const Color neutral100 = Color(0xFFF8F9FA); // Off-white
  static const Color neutral300 = Color(0xFFDEE2E6); // Light gray
  static const Color neutral500 = Color(0xFFADB5BD); // Mid gray
  static const Color neutral700 = Color(0xFF495057); // Dark gray
  static const Color neutral900 = Color(0xFF212529); // Off-black

  // Theme-specific colors
  static const Color lightSurface = neutral100;
  static const Color lightOnSurface = neutral900;
  static const Color lightPrimary = supabaseTurquoise;
  static const Color lightOnPrimary = neutral100; // Text on primary button
  static const Color lightCard = neutral300;
  static const Color lightOnCard = neutral900;
  static const Color lightSecondary = supabaseGreen;
  static const Color lightOnSecondary = neutral100;
  static const Color lightError = Color(0xFFE57373);
  static const Color lightOnError = neutral100;

  static const Color darkSurface = supabasedarkestGreen;
  static const Color darkOnSurface = neutral100;
  static const Color darkPrimary = supabaseTurquoise;
  static const Color darkOnPrimary = supabasedarkestGreen;
  static const Color darkCard = supabaseDarkGreen;
  static const Color darkOnCard = neutral100;
  static const Color darkSecondary = supabaseGreen;
  static const Color darkOnSecondary = supabasedarkestGreen;
  static const Color darkError = Color(0xFFEF5350);
  static const Color darkOnError = supabasedarkestGreen;

  static const List<Color> splashGradient = [
    Color(0xFF01B69D),
    Color(0xFF26B09B),
  ];
}