// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class DB {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   CollectionReference users = FirebaseFirestore.instance.collection('users');

//   addUser(uid, email) async {
//     try {
//       DocumentReference result = await users.add(
//         {
//           'uid': uid,
//           'email': email,
//           'favorite_hidushim': [],
//           'shared_hidushim': []
//         },
//       );
//       log('$result');
//     } on Exception catch (e) {
//       log('Failed to add user: $e');
//     }
//   }
// }
