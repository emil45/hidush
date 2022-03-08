import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hidush/models/user.dart';
import 'package:hidush/services/db.dart';
import 'package:hidush/widgets/navigation/navigation.dart';
import 'package:provider/provider.dart';

import 'authenticate/sign_in.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final DBService dbService = DBService();

  @override
  Widget build(BuildContext context) {
    final AuthenticatedUser? user = Provider.of<AuthenticatedUser?>(context);

    if (user == null) {
      return const SignIn();
    } else {
      log('User logged in. UID: ${user.uid}, Email: ${user.email}');
      return FutureBuilder(
        future: dbService.upsertUser(user),
        builder: (context, snapshot) => const Navigation(),
      );
    }
  }
}
