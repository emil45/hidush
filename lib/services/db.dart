import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidush/models/hidush.dart';
import 'package:hidush/models/user.dart';

class DBService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference hidushim = FirebaseFirestore.instance.collection('hidushim');
  late DocumentSnapshot mostRecentHidush;

  Future<void> upsertUser(AuthenticatedUser user) async {
    DocumentSnapshot snapShot = await users.doc(user.uid).get();

    if (snapShot.exists == false) {
      try {
        await users
            .doc(user.uid)
            .set({'uid': user.uid, 'email': user.email, 'likedHidushim': [], 'sharedHidushim': {}});
        log("Succesfully created user. UID: ${user.uid}, Email: ${user.email}");
      } on Exception catch (e) {
        log("Failed to create user. UID: ${user.uid}, Email: ${user.email}");
        log(e.toString());
      }
    } else {
      log("User already exists. UID: ${user.uid}, Email: ${user.email}");
    }
  }

  Future<User> getUser(String userUid) async {
    DocumentSnapshot snapshot = await users.doc(userUid).get();
    return User.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  Future<void> updateFavoriteHidush(String userUid, String hidushId, bool likeStatus) async {
    try {
      if (likeStatus) {
        await users.doc(userUid).update({
          'likedHidushim': FieldValue.arrayUnion([hidushId])
        });
        await hidushim.doc(hidushId).update({'likes': FieldValue.increment(1)});
      } else {
        await users.doc(userUid).update({
          'likedHidushim': FieldValue.arrayRemove([hidushId])
        });
        await hidushim.doc(hidushId).update({'likes': FieldValue.increment(-1)});
      }
      log("Succesfully updated the liked hidush. UserID: $userUid, HidushID: $hidushId, LikeStatus: $likeStatus");
    } on Exception catch (e) {
      log("Failed to updated liked hidush. UserID: $userUid, HidushID: $hidushId. Error: ${e.toString()}");
    }
  }

  Future<void> updateSharedHidush(String userUid, String hidushId) async {
    try {
      await users.doc(userUid).update({'sharedHidushim.$hidushId': FieldValue.increment(1)});
      await hidushim.doc(hidushId).update({'shares': FieldValue.increment(1)});
      log("Succesfully updated the shared hidush. UserID: $userUid, HidushID: $hidushId");
    } on Exception catch (e) {
      log("Failed to updated shared hidush. UserID: $userUid, HidushID: $hidushId. Error: ${e.toString()}");
    }
  }

  Future<List<Hidush>> getUserFavoriteHidushim(String userUid) async {
    DocumentSnapshot snapshot = await users.doc(userUid).get();
    List favoriteHidushim = snapshot['likedHidushim'];

    if (favoriteHidushim.isNotEmpty) {
      QuerySnapshot query = await hidushim.where(FieldPath.documentId, whereIn: favoriteHidushim).get();
      return query.docs.map((e) => Hidush.fromJson(e.data() as Map<String, dynamic>)).toList();
    } else {
      return [];
    }
  }

  Future<List<Hidush>> getHidushim({bool? refresh}) async {
    QuerySnapshot snapshot;
    if (refresh == null) {
      snapshot = await hidushim.orderBy('lastUpdate', descending: true).limit(10).get();
      mostRecentHidush = snapshot.docs[0];
    } else {
      snapshot =
          await hidushim.orderBy('lastUpdate', descending: true).endBeforeDocument(mostRecentHidush).limit(10).get();
      snapshot.docs.isNotEmpty ? mostRecentHidush = snapshot.docs[0] : null;
    }

    return snapshot.docs.map((e) => Hidush.fromJson(e.data() as Map<String, dynamic>)).toList();
  }
}
