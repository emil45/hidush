import 'package:flutter/material.dart';
import 'package:hidush/services/auth.dart';

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
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0.0,
        title: const Text("התחבר לחידוש"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: ElevatedButton(
          child: const Text("התחבר"),
          onPressed: () async {
            // dynamic result = await _auth.signInAnonymous();
            // if (result == null) {
            //   print('error');
            // } else {
            //   print("signed in");
            // }
          },
        ),
      ),
    );
  }
}
