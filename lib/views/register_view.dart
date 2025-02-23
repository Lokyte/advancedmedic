import 'package:advancedmedic/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      appBar: AppBar(
        title: const Text('Register'),
      ),
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
                        final userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        _logger.i(
                            'User registered: $userCredential'); // Log success
                        // Navigate after successful registration
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute,
                          (route) => false,
                        );
                      } on FirebaseAuthException catch (e) {
                        String errorMessage =
                            "An error occurred during registration."; // Default error message
                        if (e.code == 'weak-password') {
                          errorMessage = 'The password provided is too weak.';
                        } else if (e.code == 'email-already-in-use') {
                          errorMessage =
                              'The account already exists for that email.';
                        } else if (e.code == 'invalid-email') {
                          errorMessage = 'Invalid email entered.';
                        }
                        // Show error message to the user
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(errorMessage)),
                        );
                        _logger.e(
                            'Registration error: $errorMessage'); // Log error
                      } finally {
                        setState(() {
                          _isLoading = false; // Set loading back to false
                        });
                      }
                    },
                    child: const Text('Register'),
                  ),

            const SizedBox(height: 16), // Add spacing between buttons
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login',
                  (route) => false,
                );
              },
              child: const Text('Already Registered? Login here!'),
            ),
          ],
        ),
      ),
    );
  }
}
