import 'package:dark_cinemax/core/pages/auth/login/login.dart';
import 'package:dark_cinemax/core/pages/auth/pages/main_page.dart';
import 'package:dark_cinemax/core/pages/auth/register/register.dart';
import 'package:dark_cinemax/core/pages/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // Sign in with Google

  Future<void> _signInWithGoogle() async {
    setState(() {});

    try {
      await AuthService().signInWithGoogle();

      // Navigate to MainPage only if sign-in is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Error signing in with Google: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {});
    }
  } // signin with github

  Future<void> _signInWithGitHub() async {
    setState(() {});

    try {
      await AuthService().signInWithGitHub();

      // Navigate to MainPage only if sign-in is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Error signing in with GitHub: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Login Dark Cinemax",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  loginButtonbuild(
                    context,
                    "assets/icons/email.png",
                    "Continue with Email",
                    isdarks: true,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  loginButtonbuild(
                    context,
                    "assets/icons/facebook.png",
                    "Continue with Facebook",
                    isdarks: false,
                  ),
                  SizedBox(height: 16),
                  loginButtonbuild(
                    context,
                    "assets/icons/google.png",
                    "Continue with Google",
                    isdarks: false,
                    onPressed: _signInWithGoogle,
                  ),
                  SizedBox(height: 16),
                  loginButtonbuild(
                    context,
                    "assets/icons/github.png",
                    "Continue with GitHub",
                    isdarks: true,
                    onPressed: _signInWithGitHub,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: const Text('Don\'t have an account? Register here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@override
Widget loginButtonbuild(
  BuildContext context,
  String icon,
  String text, {
  bool isdarks = false,
  Function()? onPressed,
}) {
  bool isdark = Theme.of(context).brightness == Brightness.dark;
  return SizedBox(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.06,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        side: BorderSide(
          width: 1.5,
          color: isdark ? Colors.white : Colors.grey.withOpacity(0.3),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            icon,
            color: isdarks
                ? isdark
                      ? Colors.white
                      : Colors.black
                : null,
          ),
          Text(
            text,
            style: TextStyle(color: isdark ? Colors.white : Colors.black),
          ),
          SizedBox(width: 10),
        ],
      ),
    ),
  );
}
