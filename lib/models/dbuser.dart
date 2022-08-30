import 'package:json_annotation/json_annotation.dart';

part 'dbuser.g.dart';

class AuthenticatedUser {
  final String uid;
  final String? email;

  AuthenticatedUser({required this.email, required this.uid});
}

@JsonSerializable()
class DBUser extends AuthenticatedUser {
  List<String> likedHidushim;
  Map<String, int> sharedHidushim;

  DBUser({
    email,
    required uid,
    required this.likedHidushim,
    required this.sharedHidushim,
  }) : super(uid: uid, email: email);

  factory DBUser.fromJson(Map<String, dynamic> json) => _$DBUserFromJson(json);

  Map<String, dynamic> toJson() => _$DBUserToJson(this);
}
