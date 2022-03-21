import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hidush/common/utils.dart';
import 'package:hidush/models/hidush.dart';
import 'package:hidush/models/user.dart';
import 'package:hidush/services/db.dart';
import 'package:hidush/widgets/hidush/hidush_card.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DBService dbService = DBService();
  late List<Hidush> hidushim;
  late User user;

  Future<void> handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Hidush> newHidushim = await dbService.getHidushim(refresh: true);
    if (newHidushim.isNotEmpty) setState(() => hidushim.insertAll(0, newHidushim));
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticatedUser authUser = Provider.of<AuthenticatedUser?>(context)!;

    return FutureBuilder(
      future: Future.wait([dbService.getHidushim(), dbService.getUser(authUser.uid)]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          hidushim = snapshot.data![0];
          user = snapshot.data![1];

          return RefreshIndicator(
            onRefresh: handleRefresh,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: hidushim.length,
              itemBuilder: (BuildContext context, int index) {
                return HidushCard(
                  key: ValueKey(index),
                  id: hidushim[index].id,
                  source: hidushim[index].source,
                  sourceDetails: hidushim[index].sourceDetails,
                  quote: hidushim[index].quote,
                  peroosh: hidushim[index].peroosh,
                  categories: hidushim[index].categories,
                  rabbi: hidushim[index].rabbi,
                  rabbiImage: rabbiToImage[hidushim[index].rabbi],
                  isLiked: user.likedHidushim.contains(hidushim[index].id),
                  likes: hidushim[index].likes,
                  shares: hidushim[index].shares,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
          );
        }
      },
    );
  }
}
