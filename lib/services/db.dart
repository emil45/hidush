import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidush/models/user.dart';

class DBService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void upsertUser(AuthenticatedUser user) async {
    DocumentSnapshot snapShot = await users.doc(user.uid).get();

    if (snapShot.exists == false) {
      try {
        await users.doc(user.uid).set({
          'email': user.email,
          'favorite_hidushim': [],
          'shared_hidushim': []
        });
        log("Succesfully created user. UID: ${user.uid}, Email: ${user.email}");
      } on Exception catch (e) {
        log("Failed to create user. UID: ${user.uid}, Email: ${user.email}");
        log(e.toString());
      }
    } else {
      log("User already exists. UID: ${user.uid}, Email: ${user.email}");
    }
  }
}
