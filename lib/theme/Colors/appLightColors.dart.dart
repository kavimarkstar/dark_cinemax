import 'package:flutter/material.dart';

/// Centralized light theme color tokens for the app.
class AppLightColors {
  // Brand
  static const Color seed = Color(0XFF00CC99);
  static const Color primary = Color(0XFF00CC99);
  static const Color onPrimary = Colors.white;

  // Light surfaces
  static const Color lightBackground = Colors.white;
  static const Color lightSurface = Colors.white;

  // Common tokens
  static const Color divider = Colors.grey;
  static const Color unselected = Colors.black54;

  // Text tokens (light mode)
  static const Color textLightPrimary = Colors.black;
  static const Color textLightSecondary = Colors.black87;
  static const Color textLightTertiary = Colors.black54;

  // Text tokens (inverse/dark text on dark elements used in light theme)
  static const Color textDarkPrimary = Colors.white;
  static const Color textDarkSecondary = Colors.white70;
  static const Color textDarkTertiary = Colors.white60;

  // Icon tokens
  static const Color iconLight = Colors.black54;
  static const Color iconDark = Colors.white70;

  // Component-specific defaults for light theme
  static const Color snackBarBackground = Color(0xFF323232);
  static const Color inputEnabledBorder = Colors.grey;
  static const Color inputFocusedBorder = primary;
  static const Color sliderInactive = Colors.grey;
  static const Color scrollbarThumb = primary;
  static const Color tabUnselectedLabel = Colors.black;
  static const Color navIndicator = primary;

  // Scheme helpers
  static ColorScheme get lightColorScheme =>
      ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light);
}
