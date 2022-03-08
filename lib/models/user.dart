import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

class AuthenticatedUser {
  final String uid;
  final String? email;

  AuthenticatedUser({required this.email, required this.uid});
}

@JsonSerializable()
class User extends AuthenticatedUser {
  List<String> likedHidushim;
  Map<String, int> sharedHidushim;

  User({
    required uid,
    required email,
    required this.likedHidushim,
    required this.sharedHidushim,
  }) : super(uid: uid, email: email);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
