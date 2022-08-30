import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hidush/common/logger.dart';
import 'package:hidush/models/dbuser.dart';
import 'package:hidush/models/hidush.dart';
import 'package:quiver/iterables.dart';

final log = getLogger();

const int hidushLimit = 10;

class DBService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference hidushim = FirebaseFirestore.instance.collection('hidushim');
  DocumentSnapshot? newestHidush;
  DocumentSnapshot? oldestHidush;

  Future<void> upsertUser(User user) async {
    DocumentSnapshot snapShot = await users.doc(user.uid).get();

    if (snapShot.exists == false) {
      try {
        await users
            .doc(user.uid)
            .set({'uid': user.uid, 'email': user.email, 'likedHidushim': [], 'sharedHidushim': {}});
        log.i("Succesfully created user. UID: ${user.uid}, Email: ${user.email}");
      } on Exception catch (e) {
        log.e("Failed to create user. UID: ${user.uid}, Email: ${user.email}");
        log.e(e.toString());
      }
    } else {
      log.i("User already exists. UID: ${user.uid}, Email: ${user.email}");
    }
  }

  Future<DBUser> getUser(String userUid) async {
    DocumentSnapshot snapshot = await users.doc(userUid).get();
    DBUser dbuser = DBUser.fromJson(snapshot.data() as Map<String, dynamic>);

    log.i('Get user data. User: ${dbuser.toJson()}');
    return dbuser;
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
      log.i("Succesfully updated the liked hidush. UserID: $userUid, HidushID: $hidushId, LikeStatus: $likeStatus");
    } on Exception catch (e) {
      log.e("Failed to updated liked hidush. UserID: $userUid, HidushID: $hidushId. Error: ${e.toString()}");
    }
  }

  Future<void> updateSharedHidush(String userUid, String hidushId) async {
    try {
      await users.doc(userUid).update({'sharedHidushim.$hidushId': FieldValue.increment(1)});
      await hidushim.doc(hidushId).update({'shares': FieldValue.increment(1)});
      log.i("Succesfully updated the shared hidush. UserID: $userUid, HidushID: $hidushId");
    } on Exception catch (e) {
      log.e("Failed to updated shared hidush. UserID: $userUid, HidushID: $hidushId. Error: ${e.toString()}");
    }
  }

  Future<List<Hidush>> getUserFavoriteHidushim(String userUid) async {
    DocumentSnapshot snapshot = await users.doc(userUid).get();
    List favoriteHidushim = snapshot['likedHidushim'];
    final chunks = partition(favoriteHidushim, 10);

    if (favoriteHidushim.isNotEmpty) {
      final List querySnapshots = await Future.wait(chunks.map((chunk) {
        Query itemsQuery = hidushim.where(FieldPath.documentId, whereIn: chunk);
        return itemsQuery.get();
      }).toList());

      final docs = querySnapshots.expand((element) => element.docs);
      return docs.map((doc) => Hidush.fromJson(doc.data())).toList();
      // log(docs.toString());

      // return await Stream.fromIterable(querySnapshots).flatMap((qs) => Stream.fromIterable(qs.docs)).toList();

      // QuerySnapshot query = await hidushim.where(FieldPath.documentId, whereIn: favoriteHidushim).get();
      // return querySnapshots.reversed
      //     .map((querySnapshot) => Hidush.fromJson(querySnapshot.data() as Map<String, dynamic>))
      //     .toList();
    } else {
      return [];
    }
  }

  Future<List<Hidush>> getHidushim({bool? refresh, bool? pagination}) async {
    QuerySnapshot snapshot;
    Query query = hidushim.limit(hidushLimit).orderBy('lastUpdate', descending: true);

    if (refresh == true) {
      snapshot = await query.endBeforeDocument(newestHidush!).get();
    } else if (pagination == true) {
      snapshot = await query.startAfterDocument(oldestHidush!).get();
    } else {
      snapshot = await query.get();
    }

    if (snapshot.docs.isNotEmpty && pagination != true) newestHidush = snapshot.docs.first;
    if (snapshot.docs.isNotEmpty) oldestHidush = snapshot.docs.last;

    log.d('NewestHidush: ${newestHidush?.id}. OldestHidush: ${oldestHidush?.id}');

    return snapshot.docs.map((e) => Hidush.fromJson(e.data() as Map<String, dynamic>)).toList();
  }
}
