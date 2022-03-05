import 'package:flutter/material.dart';
import 'package:hidush/services/auth.dart';

class Personal extends StatelessWidget {
  Personal({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text("התנתק"),
      onPressed: () async {
        await _authService.signOut();
      },
    );
  }
}
