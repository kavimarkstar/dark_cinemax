import 'package:dark_cinemax/core/theme/theme_controller.dart';
import 'package:dark_cinemax/core/pages/auth/pages/wrapper.dart';
import 'package:dark_cinemax/core/database/firebase_options.dart';
import 'package:dark_cinemax/theme/dark/darkTheme.dart';
import 'package:dark_cinemax/theme/light/lightTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ThemeController.instance.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance.themeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dark Cinemax',
          theme: LightTheme.lightTheme,
          darkTheme: DarkTheme.darkTheme,
          themeMode: mode,
          home: Wrapper(),
        );
      },
    );
  }
}
