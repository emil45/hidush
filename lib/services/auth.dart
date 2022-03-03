import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Sign In Anon
  Future signInAnonymous() async {
    UserCredential userCredential = await auth.signInAnonymously();
    return userCredential.user;
  }

  // Sign In Google

  // Logout
}
