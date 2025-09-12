import 'package:flutter/material.dart';

/// Centralized color tokens for the app.
///
/// Use these in themes and widgets to keep colors consistent.
class AppDarkColors {
  // Brand
  static const Color seed = Color(0XFF00CC99);
  static const Color primary = Color(0XFF00CC99);
  static const Color onPrimary = Colors.white;

  // Light surfaces
  static const Color lightBackground = Colors.white;
  static const Color lightSurface = Colors.white;

  // Dark surfaces
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);

  // Common tokens
  static const Color divider = Colors.grey;
  static const Color unselected = Colors.white60;

  // Text tokens
  static const Color textLightPrimary = Colors.black;
  static const Color textLightSecondary = Colors.black87;
  static const Color textLightTertiary = Colors.black54;

  static const Color textDarkPrimary = Colors.white;
  static const Color textDarkSecondary = Colors.white70;
  static const Color textDarkTertiary = Colors.white60;

  // Icon tokens
  static const Color iconLight = Colors.black54;
  static const Color iconDark = Colors.white70;

  // Component-specific defaults for dark theme
  static const Color snackBarBackground = darkSurface;
  static const Color inputEnabledBorder = Colors.grey;
  static const Color inputFocusedBorder = primary;
  static const Color sliderInactive = Colors.grey;
  static const Color scrollbarThumb = primary;
  static const Color tabUnselectedLabel = textDarkPrimary;
  static const Color navIndicator = primary;

  // Scheme helpers
  static ColorScheme get lightColorScheme =>
      ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light);

  static ColorScheme get darkColorScheme =>
      ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark);
}
