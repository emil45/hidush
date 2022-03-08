import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hidush/common/utils.dart';
import 'package:hidush/models/hidush.dart';
import 'package:hidush/services/db.dart';
import 'package:hidush/widgets/hidush_card.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  DBService dbService = DBService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbService.getHidushim(),
      builder: (BuildContext context, AsyncSnapshot<List<Hidush>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<Hidush> hidushim = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(0),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return HidushCard(
                key: ValueKey(index.toString()),
                source: hidushim[index].source,
                sourceDetails: hidushim[index].sourceDetails,
                quota: hidushim[index].quota,
                peerosh: hidushim[index].peerosh,
                labels: hidushim[index].labels,
                rabbi: hidushim[index].rabbi,
                rabbiImage: rabbiToImage[hidushim[index].rabbi],
                isLiked: false,
                likes: hidushim[index].likes,
                shares: hidushim[index].shares,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          );
        }
      },
    );

    // return Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    //   child: ListView.separated(
    //     padding: const EdgeInsets.all(0.0),
    //     itemBuilder: (context, index) => cards.elementAt(index),
    //     itemCount: cards.length,
    //     separatorBuilder: (context, index) => const SizedBox(height: 10),
    //   ),
    // );
  }
}
