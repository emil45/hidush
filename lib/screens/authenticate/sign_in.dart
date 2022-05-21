import 'package:flutter/material.dart';
import 'package:hidush/services/auth.dart';
import 'package:hidush/widgets/buttons/sign_in_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 56, 73),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset('assets/images/firebase_logo.png', height: 160),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'ברוכים הבאים',
                      style: TextStyle(color: Colors.yellow, fontSize: 40),
                    ),
                    const Text(
                      'לחידוש',
                      style: TextStyle(color: Colors.orange, fontSize: 40),
                    ),
                  ],
                ),
              ),
              SignInButton(
                icon: const Image(
                  image: AssetImage("assets/images/google_logo.png"),
                  height: 20.0,
                ),
                buttonText: 'התחברות עם Google',
                onPress: _auth.signInWithGoogle,
              ),
              // SignInButton(
              //   icon: const Icon(Icons.person, size: 25.0),
              //   buttonText: 'התחברות אנונימית',
              //   onPress: _auth.signInAnonymous,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
