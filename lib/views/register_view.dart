import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final Logger _logger = Logger();
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
      body: Column(
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
                      _logger.i(userCredential);
                      // Navigate after successful registration
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     '/login', (route) => false); // Or another route
                    } on FirebaseAuthException catch (e) {
                      // String errorMessage =
                      //     "An error occurred during registration."; // Default error message
                      if (e.code == 'weak-password') {
                        _logger.e('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        _logger.e('The account already exists for that email.');
                      } else if (e.code == 'invalid-email') {
                        _logger.e('Invalid email entered.');
                      }
                    } finally {
                      setState(() {
                        _isLoading = false; // Set loading back to false
                      });
                    }
                  },
                  child: const Text('Register'),
                ),

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
    );
  }
}
