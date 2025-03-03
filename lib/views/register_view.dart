import 'package:advancedmedic/constants/routes.dart';
import 'package:advancedmedic/services/auth/auth_exceptions.dart';
import 'package:advancedmedic/services/auth/auth_service.dart';
import 'package:advancedmedic/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

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
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  AuthService.firebase().sendEmailVerification;
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                } on WeakPasswordAuthException {
                  await showErrorDialog(context, 'Weak-password');
                } on EmailAlreadyInUseAuthException {
                  await showErrorDialog(context, 'Email already in use ');
                } on InvalidEmailAuthException {
                  await showErrorDialog(
                    context,
                    'This is an invalid email address',
                  );
                } on GenericAuthException {
                  await showErrorDialog(context, 'Failed to rregister');
                }
              },
              child: const Text('Register'),
            ),
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
