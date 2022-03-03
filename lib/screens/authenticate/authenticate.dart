import 'package:flutter/material.dart';
import 'package:hidush/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  AuthenticateState createState() => AuthenticateState();
}

class AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return const SignIn();
  }
}
