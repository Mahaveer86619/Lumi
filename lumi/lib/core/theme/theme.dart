import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lumi/core/theme/pallete.dart';


ThemeData lightMode = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.nunitoSansTextTheme(),
  colorScheme: ColorScheme.light(
    surface: Pallete.lightSurface,
    onSurface: Pallete.lightOnSurface,
    primary: Pallete.lightPrimary,
    onPrimary: Pallete.lightOnPrimary,
    primaryContainer: Pallete.lightCard, 
    onPrimaryContainer: Pallete.lightOnCard,
    secondary: Pallete.lightSecondary,
    onSecondary: Pallete.lightOnSecondary,
    secondaryContainer: Pallete.lightSecondary.withOpacity(0.2),
    onSecondaryContainer: Pallete.lightOnSurface,
    tertiary: Pallete.neutral700,
    onTertiary: Pallete.lightOnPrimary,
    tertiaryContainer: Pallete.neutral500,
    onTertiaryContainer: Pallete.lightOnSurface,
    error: Pallete.lightError,
    onError: Pallete.lightOnError,
    errorContainer: Pallete.lightError.withOpacity(0.2),
    onErrorContainer: Pallete.lightOnError,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Pallete.darkSurface,
    foregroundColor: Pallete.lightOnPrimary,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    enableFeedback: false,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedItemColor: Pallete.darkOnSurface,
    unselectedItemColor: Pallete.neutral500,
    selectedIconTheme: IconThemeData(color: Pallete.darkOnSurface),
    unselectedIconTheme: IconThemeData(color: Pallete.neutral500),
    selectedLabelStyle: TextStyle(
      color: Pallete.darkOnSurface,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: TextStyle(color: Pallete.neutral500),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.nunitoSansTextTheme(),
  colorScheme: ColorScheme.dark(
    surface: Pallete.darkSurface,
    onSurface: Pallete.darkOnSurface,
    primary: Pallete.darkPrimary,
    onPrimary: Pallete.darkOnPrimary,
    primaryContainer: Pallete.darkCard,
    onPrimaryContainer: Pallete.darkOnCard,
    secondary: Pallete.darkSecondary,
    onSecondary: Pallete.darkOnSecondary,
    secondaryContainer: Pallete.darkSecondary.withOpacity(0.2),
    onSecondaryContainer: Pallete.darkOnSurface,
    tertiary: Pallete.neutral500,
    onTertiary: Pallete.darkOnPrimary,
    tertiaryContainer: Pallete.neutral500,
    onTertiaryContainer: Pallete.darkOnSurface,
    error: Pallete.darkError,
    onError: Pallete.darkOnError,
    errorContainer: Pallete.darkError.withOpacity(0.2),
    onErrorContainer: Pallete.darkOnError,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Pallete.darkCard,
    foregroundColor: Pallete.darkOnSurface,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.shifting,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedItemColor: Pallete.darkOnSurface,
    unselectedItemColor: Pallete.neutral500,
    selectedIconTheme: IconThemeData(color: Pallete.darkOnSurface),
    unselectedIconTheme: IconThemeData(color: Pallete.neutral500),
    selectedLabelStyle: TextStyle(
      color: Pallete.darkOnSurface,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: TextStyle(color: Pallete.neutral500),
  ),
);