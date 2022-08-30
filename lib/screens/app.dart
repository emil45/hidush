import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hidush/common/logger.dart';
import 'package:hidush/services/db.dart';
import 'package:hidush/widgets/navigation/navigation.dart';

import 'authenticate/sign_in.dart';

final log = getLogger();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final DBService dbService = DBService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            User user = (snapshot.data as User);
            return FutureBuilder(
              future: dbService.upsertUser(user),
              builder: (context, snapshot) => const Navigation(),
            );
          } else {
            return const SignIn();
          }
        });
  }
}
