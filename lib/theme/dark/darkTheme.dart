import 'package:dark_cinemax/theme/Colors/appDarkColors.dart';
import 'package:flutter/material.dart';

/// Provides the app-wide Material 3 dark theme.
///
/// Keep tokens derived from `colorScheme` so components stay consistent when
/// brand colors or contrast requirements change.
class DarkTheme {
  /// Central access point for the dark [ThemeData].
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      colorScheme: AppDarkColors.darkColorScheme,
      scaffoldBackgroundColor: AppDarkColors.darkBackground,
      // High-contrast app bar on dark surfaces
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: AppDarkColors.darkSurface,
        foregroundColor: Colors.white,
      ),
      // Default card appearance used across the app
      cardTheme: const CardThemeData(
        elevation: 2,
        color: AppDarkColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: AppDarkColors.primary,
          foregroundColor: AppDarkColors.onPrimary,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: AppDarkColors.primary,
        foregroundColor: AppDarkColors.onPrimary,
      ),
      // Text fields: filled style with subtle borders for dark backgrounds
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppDarkColors.inputEnabledBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppDarkColors.inputEnabledBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppDarkColors.inputFocusedBorder,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        fillColor: AppDarkColors.darkSurface,
        filled: true,
      ),
      // Accessible text colors tuned for dark mode
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
        bodySmall: TextStyle(color: Colors.white60),
        headlineLarge: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
        labelLarge: TextStyle(color: Colors.white),
        labelMedium: TextStyle(color: Colors.white70),
        labelSmall: TextStyle(color: Colors.white60),
      ),
      dividerTheme: const DividerThemeData(
        color: AppDarkColors.divider,
        thickness: 0.5,
      ),
      listTileTheme: const ListTileThemeData(
        textColor: Colors.white,
        iconColor: Colors.white70,
      ),
      // Uses primary for selection; onSurfaceVariant for unselected state
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppDarkColors.darkSurface,
        selectedItemColor: AppDarkColors.textDarkPrimary,
        unselectedItemColor: AppDarkColors.unselected,
        type: BottomNavigationBarType.fixed,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppDarkColors.darkSurface,
      ),
      // M3 navigation bar styling for dark backgrounds
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppDarkColors.darkSurface,
        indicatorColor: AppDarkColors.navIndicator,
        labelTextStyle: const WidgetStatePropertyAll(
          TextStyle(color: Colors.white),
        ),
        iconTheme: const WidgetStatePropertyAll(
          IconThemeData(color: Colors.white70),
        ),
      ),
      // Icon builders cannot be const; provides consistent nav/action icons
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (_) => Icon(Icons.arrow_back),
        closeButtonIconBuilder: (_) => Icon(Icons.close),
        drawerButtonIconBuilder: (_) => Icon(Icons.menu),
        endDrawerButtonIconBuilder: (_) => Icon(Icons.menu),
      ),
      // Surface-colored menus with readable text
      popupMenuTheme: const PopupMenuThemeData(
        color: AppDarkColors.darkSurface,
        textStyle: TextStyle(color: Colors.white),
      ),
      // Dialogs aligned with dark surface colors
      dialogTheme: const DialogThemeData(
        backgroundColor: AppDarkColors.darkSurface,
        titleTextStyle: TextStyle(color: Colors.white),
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppDarkColors.darkSurface,
      ),
      // Surface defaults for components that inherit canvas/card colors
      chipTheme: const ChipThemeData(
        backgroundColor: AppDarkColors.darkSurface,
      ),
      badgeTheme: const BadgeThemeData(
        backgroundColor: AppDarkColors.darkSurface,
      ),
      bannerTheme: const MaterialBannerThemeData(
        backgroundColor: AppDarkColors.darkSurface,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: AppDarkColors.darkSurface,
      ),
      canvasColor: AppDarkColors.darkSurface,
      cardColor: AppDarkColors.darkSurface,
      dividerColor: Colors.grey,
      // Small, consistent padding for legacy ButtonBar usages
      buttonBarTheme: const ButtonBarThemeData(
        buttonPadding: EdgeInsets.all(8),
      ),
      focusColor: Colors.deepPurple,
      // High-contrast table text for analytics/admin screens
      dataTableTheme: const DataTableThemeData(
        dataTextStyle: TextStyle(color: Colors.white),
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        collapsedIconColor: Colors.white,
        collapsedTextColor: Colors.white,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      dropdownMenuTheme: const DropdownMenuThemeData(
        textStyle: TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      // Snack bars use inverse surfaces for contrast over content
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppDarkColors.primary,
        inactiveTrackColor: AppDarkColors.sliderInactive,
        thumbColor: AppDarkColors.primary,
        valueIndicatorColor: AppDarkColors.primary,
      ),
      // Control themes unified on brand primary
      checkboxTheme: CheckboxThemeData(
        fillColor: const WidgetStatePropertyAll(AppDarkColors.primary),
        checkColor: const WidgetStatePropertyAll(AppDarkColors.onPrimary),
      ),
      radioTheme: RadioThemeData(
        fillColor: const WidgetStatePropertyAll(AppDarkColors.primary),
      ),
      switchTheme: SwitchThemeData(
        trackColor: const WidgetStatePropertyAll(AppDarkColors.primary),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppDarkColors.primary,
          foregroundColor: AppDarkColors.onPrimary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppDarkColors.textDarkPrimary,
          side: const BorderSide(color: AppDarkColors.primary),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppDarkColors.primary),
      ),
      // Cursor matches brand primary for discoverability
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.deepPurple,
      ),
      toggleButtonsTheme: const ToggleButtonsThemeData(
        color: AppDarkColors.primary,
        selectedColor: AppDarkColors.onPrimary,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppDarkColors.primary,
      ),
      // Secondary navigation on dark surfaces
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: AppDarkColors.darkSurface,
        indicatorColor: Colors.deepPurple,
      ),
      // Icon buttons follow primary/contrast tokens
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: AppDarkColors.primary,
          foregroundColor: AppDarkColors.onPrimary,
        ),
      ),
      scrollbarTheme: const ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(AppDarkColors.scrollbarThumb),
      ),
      // Tabs use primary for emphasis; white for unselected legibility
      tabBarTheme: const TabBarThemeData(
        labelColor: AppDarkColors.primary,
        unselectedLabelColor: AppDarkColors.tabUnselectedLabel,
      ),
    );
  }
}
