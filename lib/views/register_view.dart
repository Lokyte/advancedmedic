import 'dart:math' as devtools;

import 'package:advancedmedic/constants/routes.dart';
import 'package:advancedmedic/utilities/show_error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart'; // Correct import for the logger package

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final _logger = Logger(); // Correct usage of the logger package
  bool _isLoading = false; // Add a loading state

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding for better layout
        child: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email here',
              ),
            ),
            const SizedBox(height: 16), // Add spacing between fields
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Enter your password here',
                border: OutlineInputBorder(), // Add border for better UX
              ),
            ),
            const SizedBox(height: 24), // Add spacing before buttons

            _isLoading // Show loading indicator while registering
                ? const CircularProgressIndicator()
                : TextButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true; // Set loading to true
                    });
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                      final user = FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                      Navigator.of(context).pushNamed(verifyEmailRoute);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'Weak-password') {
                        await showErrorDialog(context, 'Weak password');
                      } else if (e.code == 'Email already in use') {
                        showErrorDialog(context, 'Email already in use');
                      } else if (e.code == 'invalid email') {
                        showErrorDialog(context, 'Invalid email address');
                      } else {
                        showErrorDialog(context, 'Error: ${e.code}');
                      }
                    } catch (e) {
                      showErrorDialog(context, e.toString());
                    } finally {
                      setState(() {
                        _isLoading = false; // Reset loading state
                      });
                    }
                  },
                  child: const Text('Register'),
                ),

            const SizedBox(height: 16), // Add spacing between buttons
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/login', (route) => false);
              },
              child: const Text('Already Registered? Login here!'),
            ),
          ],
        ),
      ),
    );
  }
}
