class AuthenticatedUser {
  final String uid;
  final String? email;

  AuthenticatedUser({required this.email, required this.uid});
}

class User extends AuthenticatedUser {
  List<String> likedHidushim;
  List<String> sharedHidushim;

  User({
    required uid,
    required email,
    required this.likedHidushim,
    required this.sharedHidushim,
  }) : super(uid: uid, email: email);
}
