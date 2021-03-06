import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hidush/common/firebase_options.dart';
import 'package:hidush/models/user.dart' hide User;

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  AuthenticatedUser? _serializeFirebaseUser(User? user) {
    return user != null ? AuthenticatedUser(uid: user.uid, email: user.email) : null;
  }

  static Future<FirebaseApp> initializeFirebase() async {
    // if (Firebase.apps.isEmpty) {
    log("[INFO] Initialzing firebase");
    return await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // } else {
    //   return Firebase.app();
    // }
  }

  // Sign In Anon
  Future<AuthenticatedUser?> signInAnonymous() async {
    try {
      UserCredential userCredential = await auth.signInAnonymously();
      return _serializeFirebaseUser(userCredential.user);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<AuthenticatedUser?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      // Create a new credential
      final credential =
          GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // Once signed in, return the UserCredential
      UserCredential userCredential = await auth.signInWithCredential(credential);
      return _serializeFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        log('[ERROR] account-exists-with-different-credential');
      } else if (e.code == 'invalid-credential') {
        log('[ERROR] invalid-credential');
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Auth change user stream
  Stream<AuthenticatedUser?> get user {
    return auth.authStateChanges().map(_serializeFirebaseUser);
  }

  // Sign In Google

  // Logout
  Future signOut() async {
    try {
      await auth.signOut();
      await GoogleSignIn().signOut();
      log("[INFO] User sign out");
    } on Exception catch (e) {
      log('[ERROR] ${e.toString()}');
    }
  }
}
