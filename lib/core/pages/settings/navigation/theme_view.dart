import 'package:dark_cinemax/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class ThemeChange extends StatelessWidget {
  final VoidCallback? onLogoutSuccess;

  const ThemeChange({super.key, this.onLogoutSuccess});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ValueListenableBuilder<ThemeMode>(
        valueListenable: ThemeController.instance.themeMode,
        builder: (context, mode, _) {
          final isDark = mode == ThemeMode.dark;
          return Icon(isDark ? Icons.dark_mode : Icons.light_mode);
        },
      ),

      title: Text(
        "Dark Theme",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      onTap: () {
        final isDark = ThemeController.instance.isDark;
        ThemeController.instance.toggle(!isDark);
      },
      trailing: ValueListenableBuilder<ThemeMode>(
        valueListenable: ThemeController.instance.themeMode,
        builder: (context, mode, _) {
          final isDark = mode == ThemeMode.dark;
          return Switch(
            value: isDark,
            onChanged: (val) {
              ThemeController.instance.toggle(val);
            },
          );
        },
      ),
    );
  }
}
