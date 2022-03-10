import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hidush/common/utils.dart';
import 'package:hidush/models/hidush.dart';
import 'package:hidush/models/user.dart';
import 'package:hidush/services/db.dart';
import 'package:hidush/widgets/hidush_card.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  DBService dbService = DBService();
  late List<Hidush> hidushim;

  void handleLikePress(String index) {
    setState(() {
      hidushim.removeAt(int.parse(index));
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticatedUser? user = Provider.of<AuthenticatedUser?>(context, listen: false);

    return FutureBuilder(
        future: dbService.getUserFavoriteHidushim(user!.uid),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            hidushim = snapshot.data!;
            if (hidushim.isEmpty) {
              return const Center(child: Text("אין לך חידושים מועדפים"));
            }
            return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return HidushCard(
                    key: ValueKey(index.toString()),
                    id: hidushim[index].id,
                    source: hidushim[index].source,
                    sourceDetails: hidushim[index].sourceDetails,
                    quote: hidushim[index].quote,
                    peroosh: hidushim[index].peroosh,
                    categories: hidushim[index].categories,
                    rabbi: hidushim[index].rabbi,
                    rabbiImage: rabbiToImage[hidushim[index].rabbi],
                    isLiked: true,
                    likes: hidushim[index].likes,
                    shares: hidushim[index].shares,
                    likePressed: handleLikePress,
                  );
                });
          }
        });
  }
}
