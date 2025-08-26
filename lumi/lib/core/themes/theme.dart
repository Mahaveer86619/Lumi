import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_pallete.dart';

/// Defines the light theme for the application using Material 3 specifications.
ThemeData lightMode = ThemeData(
  // Enables Material 3 design system features.
  useMaterial3: true,
  // Sets the default text theme using Google Fonts (Nunito Sans).
  textTheme: GoogleFonts.nunitoSansTextTheme(),

  // --- Color Scheme for Light Theme ---
  // Defines the semantic colors used throughout the application.
  colorScheme: ColorScheme.light(
    // Background and Surface Colors
    surface: Pallete
        .lightSurface, // The primary background color for most components.
    onSurface: Pallete.lightOnSurface, // Color for text/icons on `surface`.
    // Primary Colors
    primary: Pallete
        .lightPrimary, // The main brand color, used for prominent elements.
    onPrimary: Pallete.lightOnPrimary, // Color for text/icons on `primary`.
    primaryContainer: Pallete
        .lightCard, // A container color derived from primary, often for cards or dialogs.
    onPrimaryContainer:
        Pallete.lightOnCard, // Color for text/icons on `primaryContainer`.
    // Secondary Colors
    secondary: Pallete
        .lightSecondary, // A secondary brand color, used for less prominent actions.
    onSecondary:
        Pallete.lightOnSecondary, // Color for text/icons on `secondary`.
    secondaryContainer: Pallete.lightSecondary.withAlpha(
      70,
    ), // A container color derived from secondary.
    onSecondaryContainer:
        Pallete.lightOnSurface, // Color for text/icons on `secondaryContainer`.
    // Tertiary Colors
    tertiary: Pallete
        .lightTertiary, // A third accent color, often for specific states or accents.
    onTertiary: Pallete.lightOnTertiary, // Color for text/icons on `tertiary`.
    tertiaryContainer: Pallete.lightTertiary.withAlpha(
      70,
    ), // A container color derived from tertiary.
    onTertiaryContainer:
        Pallete.lightOnSurface, // Color for text/icons on `tertiaryContainer`.
    // Error Colors
    error: Pallete.lightError, // Color for error indications and warnings.
    onError: Pallete.lightOnError, // Color for text/icons on `error`.
    errorContainer: Pallete.lightError.withAlpha(
      70,
    ), // A container color derived from error.
    onErrorContainer:
        Pallete.lightOnError, // Color for text/icons on `errorContainer`.
    // Additional Material 3 properties (optional, often derived or set implicitly)
    // background: Pallete.lightSurface, // Often the same as surface
    // onBackground: Pallete.lightOnSurface, // Often the same as onSurface
  ),

  // --- App Bar Theme ---
  // Customizes the appearance of AppBar widgets.
  appBarTheme: const AppBarTheme(
    backgroundColor: Pallete.appBarColor, // Background color of the app bar.
    foregroundColor:
        Pallete.darkOnSurface, // Color for app bar title and icons.
    elevation: 0, // Removes shadow from the app bar.
  ),

  // --- Bottom Navigation Bar Theme ---
  // Customizes the appearance of BottomNavigationBar widgets.
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    enableFeedback: false, // Disables haptic feedback on tap.
    showSelectedLabels: true, // Shows labels for selected items.
    showUnselectedLabels: true, // Shows labels for unselected items.
    selectedItemColor:
        Pallete.lightOnSurface, // Color for the selected item (icon and label).
    unselectedItemColor: Pallete.greyColor, // Color for unselected items.
    selectedIconTheme: IconThemeData(
      color: Pallete.lightOnSurface,
    ), // Icon theme for selected icons.
    unselectedIconTheme: IconThemeData(
      color: Pallete.greyColor,
    ), // Icon theme for unselected icons.
    selectedLabelStyle: TextStyle(
      color: Pallete.lightOnSurface,
      fontWeight: FontWeight.bold,
    ), // Style for selected labels.
    unselectedLabelStyle: TextStyle(
      color: Pallete.greyColor,
    ), // Style for unselected labels.
  ),
);

/// Defines the dark theme for the application using Material 3 specifications.
ThemeData darkMode = ThemeData(
  // Enables Material 3 design system features.
  useMaterial3: true,
  // Sets the default text theme using Google Fonts (Nunito Sans).
  textTheme: GoogleFonts.nunitoSansTextTheme(),

  // --- Color Scheme for Dark Theme ---
  // Defines the semantic colors used throughout the application.
  colorScheme: ColorScheme.dark(
    // Background and Surface Colors
    surface: Pallete
        .darkSurface, // The primary background color for most components.
    onSurface: Pallete.darkOnSurface, // Color for text/icons on `surface`.
    // Primary Colors
    primary: Pallete
        .darkPrimary, // The main brand color, used for prominent elements.
    onPrimary: Pallete.darkOnPrimary, // Color for text/icons on `primary`.
    primaryContainer: Pallete
        .darkCard, // A container color derived from primary, often for cards or dialogs.
    onPrimaryContainer:
        Pallete.darkOnCard, // Color for text/icons on `primaryContainer`.
    // Secondary Colors
    secondary: Pallete
        .darkSecondary, // A secondary brand color, used for less prominent actions.
    onSecondary: Pallete
        .darkOnSecondary, // Color for text/icons on `secondary` (adjusted for dark theme contrast).
    secondaryContainer: Pallete.darkSecondary.withAlpha(
      70,
    ), // A container color derived from secondary.
    onSecondaryContainer:
        Pallete.darkOnSurface, // Color for text/icons on `secondaryContainer`.
    // Tertiary Colors
    tertiary: Pallete
        .darkTertiary, // A third accent color, often for specific states or accents.
    onTertiary: Pallete
        .darkOnTertiary, // Color for text/icons on `tertiary` (adjusted for dark theme contrast).
    tertiaryContainer: Pallete.darkTertiary.withAlpha(
      70,
    ), // A container color derived from tertiary.
    onTertiaryContainer:
        Pallete.darkOnTertiary, // Color for text/icons on `tertiaryContainer`.
    // Error Colors
    error: Pallete.darkError, // Color for error indications and warnings.
    onError: Pallete
        .darkOnError, // Color for text/icons on `error` (adjusted for dark theme contrast).
    errorContainer: Pallete.darkError.withAlpha(
      70,
    ), // A container color derived from error.
    onErrorContainer:
        Pallete.darkOnError, // Color for text/icons on `errorContainer`.
  ),

  // --- App Bar Theme ---
  // Customizes the appearance of AppBar widgets.
  appBarTheme: const AppBarTheme(
    backgroundColor: Pallete.appBarColor, // Background color of the app bar.
    foregroundColor:
        Pallete.darkOnSurface, // Color for app bar title and icons.
    elevation: 0, // Removes shadow from the app bar.
  ),

  // --- Bottom Navigation Bar Theme ---
  // Customizes the appearance of BottomNavigationBar widgets.
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType
        .shifting, // Uses shifting type for dark mode (can be fixed).
    showSelectedLabels: true, // Shows labels for selected items.
    showUnselectedLabels: true, // Shows labels for unselected items.
    selectedItemColor:
        Pallete.darkOnSurface, // Color for the selected item (icon and label).
    unselectedItemColor: Pallete.greyColor, // Color for unselected items.
    selectedIconTheme: IconThemeData(
      color: Pallete.darkOnSurface,
    ), // Icon theme for selected icons.
    unselectedIconTheme: IconThemeData(
      color: Pallete.greyColor,
    ), // Icon theme for unselected icons.
    selectedLabelStyle: TextStyle(
      color: Pallete.darkOnSurface,
      fontWeight: FontWeight.bold,
    ), // Style for selected labels.
    unselectedLabelStyle: TextStyle(
      color: Pallete.greyColor,
    ), // Style for unselected labels.
  ),
);
