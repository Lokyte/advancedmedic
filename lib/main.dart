import 'package:advancedmedic/firebase_options.dart';
import 'package:advancedmedic/views/login_view.dart';
import 'package:advancedmedic/views/register_view.dart';
import 'package:advancedmedic/views/verify_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
        '/verify-email/': (context) => const VerifyEmailView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (!user.emailVerified) {
                // If email is not verified, navigate to VerifyEmailView
                return const VerifyEmailView();
              } else {
                // If email is verified, navigate to LoginView
                return const LoginView();
              }
            } else {
              // If no user is logged in, navigate to LoginView
              return const LoginView();
            }
          default:
            // Show a loading indicator while Firebase is initializing
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
