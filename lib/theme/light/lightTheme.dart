import 'package:dark_cinemax/theme/Colors/appLightColors.dart.dart';
import 'package:flutter/material.dart';

/// Provides the app-wide Material 3 light theme.
///
/// Keep tokens derived from `colorScheme` so components stay consistent when
/// brand colors or contrast requirements change.
class LightTheme {
  /// Central access point for the light [ThemeData].
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      colorScheme: AppLightColors.lightColorScheme,
      scaffoldBackgroundColor: AppLightColors.lightBackground,
      // App bar on light surfaces
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: AppLightColors.lightSurface,
        foregroundColor: AppLightColors.textLightPrimary,
      ),
      // Default card appearance used across the app
      cardTheme: const CardThemeData(
        elevation: 1,
        color: AppLightColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: AppLightColors.primary,
          foregroundColor: AppLightColors.onPrimary,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: AppLightColors.primary,
        foregroundColor: AppLightColors.onPrimary,
      ),
      // Text fields: outlined style with subtle borders for light backgrounds
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppLightColors.inputEnabledBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppLightColors.inputEnabledBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppLightColors.inputFocusedBorder,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        fillColor: AppLightColors.lightSurface,
        filled: true,
      ),
      // Accessible text colors tuned for light mode
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppLightColors.textLightPrimary),
        bodyMedium: TextStyle(color: AppLightColors.textLightSecondary),
        bodySmall: TextStyle(color: AppLightColors.textLightTertiary),
        headlineLarge: TextStyle(color: AppLightColors.textLightPrimary),
        headlineMedium: TextStyle(color: AppLightColors.textLightPrimary),
        headlineSmall: TextStyle(color: AppLightColors.textLightPrimary),
        titleLarge: TextStyle(color: AppLightColors.textLightPrimary),
        titleMedium: TextStyle(color: AppLightColors.textLightPrimary),
        titleSmall: TextStyle(color: AppLightColors.textLightPrimary),
        labelLarge: TextStyle(color: AppLightColors.textLightPrimary),
        labelMedium: TextStyle(color: AppLightColors.textLightSecondary),
        labelSmall: TextStyle(color: AppLightColors.textLightTertiary),
      ),
      dividerTheme: const DividerThemeData(
        color: AppLightColors.divider,
        thickness: 0.5,
      ),
      listTileTheme: const ListTileThemeData(
        textColor: AppLightColors.textLightPrimary,
        iconColor: AppLightColors.iconLight,
      ),
      // Uses primary for selection; subdued for unselected state
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppLightColors.lightSurface,
        selectedItemColor: AppLightColors.textLightPrimary,
        unselectedItemColor: AppLightColors.unselected,
        type: BottomNavigationBarType.fixed,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppLightColors.lightSurface,
      ),
      // M3 navigation bar styling for light backgrounds
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppLightColors.lightSurface,
        indicatorColor: AppLightColors.navIndicator,
        labelTextStyle: const WidgetStatePropertyAll(
          TextStyle(color: AppLightColors.textLightPrimary),
        ),
        iconTheme: const WidgetStatePropertyAll(
          IconThemeData(color: AppLightColors.iconLight),
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
        color: AppLightColors.lightSurface,
        textStyle: TextStyle(color: AppLightColors.textLightPrimary),
      ),
      // Dialogs aligned with light surface colors
      dialogTheme: const DialogThemeData(
        backgroundColor: AppLightColors.lightSurface,
        titleTextStyle: TextStyle(color: AppLightColors.textLightPrimary),
        contentTextStyle: TextStyle(color: AppLightColors.textLightPrimary),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppLightColors.lightSurface,
      ),
      // Surface defaults for components that inherit canvas/card colors
      chipTheme: const ChipThemeData(backgroundColor: Color(0xFFF2F2F2)),
      badgeTheme: const BadgeThemeData(backgroundColor: Color(0xFFE0E0E0)),
      bannerTheme: const MaterialBannerThemeData(
        backgroundColor: Color(0xFFF5F5F5),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: AppLightColors.lightSurface,
      ),
      canvasColor: AppLightColors.lightSurface,
      cardColor: AppLightColors.lightSurface,
      dividerColor: AppLightColors.divider,
      // Small, consistent padding for legacy ButtonBar usages
      buttonBarTheme: const ButtonBarThemeData(
        buttonPadding: EdgeInsets.all(8),
      ),
      focusColor: AppLightColors.primary,
      // Table text for light screens
      dataTableTheme: const DataTableThemeData(
        dataTextStyle: TextStyle(color: AppLightColors.textLightPrimary),
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        collapsedIconColor: AppLightColors.textLightPrimary,
        collapsedTextColor: AppLightColors.textLightPrimary,
        textColor: AppLightColors.textLightPrimary,
        iconColor: AppLightColors.textLightPrimary,
      ),
      dropdownMenuTheme: const DropdownMenuThemeData(
        textStyle: TextStyle(color: AppLightColors.textLightPrimary),
      ),
      iconTheme: const IconThemeData(color: AppLightColors.textLightPrimary),
      // Snack bars use dark surfaces for contrast over content
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppLightColors.snackBarBackground,
        contentTextStyle: TextStyle(color: AppLightColors.textDarkPrimary),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppLightColors.primary,
        inactiveTrackColor: AppLightColors.sliderInactive,
        thumbColor: AppLightColors.primary,
        valueIndicatorColor: AppLightColors.primary,
      ),
      // Control themes unified on brand primary
      checkboxTheme: CheckboxThemeData(
        fillColor: const WidgetStatePropertyAll(AppLightColors.primary),
        checkColor: const WidgetStatePropertyAll(AppLightColors.onPrimary),
      ),
      radioTheme: RadioThemeData(
        fillColor: const WidgetStatePropertyAll(AppLightColors.primary),
      ),
      switchTheme: SwitchThemeData(
        trackColor: const WidgetStatePropertyAll(AppLightColors.primary),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppLightColors.primary,
          foregroundColor: AppLightColors.onPrimary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppLightColors.primary,
          side: const BorderSide(color: AppLightColors.primary),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppLightColors.primary),
      ),
      // Cursor matches brand primary for discoverability
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppLightColors.primary,
      ),
      toggleButtonsTheme: const ToggleButtonsThemeData(
        color: AppLightColors.primary,
        selectedColor: AppLightColors.onPrimary,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppLightColors.primary,
      ),
      // Secondary navigation on light surfaces
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: AppLightColors.lightSurface,
        indicatorColor: AppLightColors.navIndicator,
      ),
      // Icon buttons follow primary/contrast tokens
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: AppLightColors.primary,
          foregroundColor: AppLightColors.onPrimary,
        ),
      ),
      scrollbarTheme: const ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(AppLightColors.scrollbarThumb),
      ),
      // Tabs use primary for emphasis; black for unselected legibility
      tabBarTheme: const TabBarThemeData(
        labelColor: AppLightColors.primary,
        unselectedLabelColor: AppLightColors.tabUnselectedLabel,
      ),
    );
  }
}
