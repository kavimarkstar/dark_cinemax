import 'package:dark_cinemax/core/pages/auth/pages/wrapper.dart';
import 'package:dark_cinemax/core/pages/auth/services/auth_service.dart';
import 'package:dark_cinemax/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class Logouts extends StatefulWidget {
  final VoidCallback? onLogoutSuccess;

  const Logouts({super.key, this.onLogoutSuccess});

  @override
  State<Logouts> createState() => _LogoutsState();
}

class _LogoutsState extends State<Logouts> {
  //ge the user id
  final String userId = AuthService().getCurrentUser()?.uid ?? 'Unknown';

  //sign out
  void _signOut(BuildContext context) {
    AuthService().signOut();
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => const Wrapper()));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ValueListenableBuilder<ThemeMode>(
        valueListenable: ThemeController.instance.themeMode,
        builder: (context, mode, _) {
          final isDark = mode == ThemeMode.dark;
          return Icon(isDark ? Icons.logout : Icons.logout, color: Colors.red);
        },
      ),

      title: Text(
        "Logout",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      onTap: () {
        _signOut(context);
      },
    );
  }
}
