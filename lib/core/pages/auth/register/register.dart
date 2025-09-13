import 'package:dark_cinemax/core/pages/auth/login/login.dart';

import 'package:dark_cinemax/core/pages/auth/services/auth_service.dart';
import 'package:dark_cinemax/core/pages/auth/widget/button.dart';
import 'package:dark_cinemax/main.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return; // Form validation failed, do not proceed
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final confirmPassword = _confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Passwords do not match.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      await AuthService().createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Error registering user: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  } // Sign in with Google

  Future<void> _signInWithGoogle() async {
    setState(() {});

    try {
      await AuthService().signInWithGoogle();

      // Navigate to MainPage only if sign-in is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
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
        MaterialPageRoute(builder: (context) => MyApp()),
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

  Future<void> _signInWithFacebook() async {
    setState(() {});

    try {
      await AuthService().signInWithFacebook();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Error signing in with Facebook: $e'),
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Register Dark Cinemax",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!RegExp(
                      r'^[^@]+@[^@]+\.[^@]+',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          onPressed: _register,
                          child: const Text('Register'),
                        ),
                      ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 2,

                      width: MediaQuery.of(context).size.width * 0.3,
                    ),

                    Text("or"),
                    Container(
                      color: Colors.grey,
                      height: 2,

                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                      onPressed: _signInWithFacebook,
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
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text('Already have an account? Login here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
