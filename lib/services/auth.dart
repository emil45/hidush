import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hidush/common/logger.dart';
import 'package:hidush/common/utils.dart';

final log = getLogger();

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Sign In Anon
  Future<void> signInAnonymous() async {
    try {
      await firebaseAuth.signInAnonymously();
    } catch (e) {
      dialog('Error', e.toString());
      log.e(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      log.d("Trying to sign in to google");
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential =
          GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);

      User? user = userCredential.user;
      log.i("User successfully signed in. Email: ${user!.email}, DisplayName: ${user.displayName}, UID: ${user.uid}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        log.e('account-exists-with-different-credential');
      } else if (e.code == 'invalid-credential') {
        log.e('invalid-credential');
      }
      dialog('Error', e.message.toString());
      log.e(e.message);
      rethrow;
    } on Exception catch (e) {
      dialog('Error', e.toString());
      log.e(e.toString());
    }
  }

  // Sign In Google

  // Logout
  Future signOut() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
      log.i("User sign out");
    } on Exception catch (e) {
      dialog('Error', e.toString());
      log.e(e.toString());
    }
  }
}
