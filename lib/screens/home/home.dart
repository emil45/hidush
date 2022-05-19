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
  List<Hidush> hidushim = [];
  final scrollController = ScrollController();
  late User user;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    fetchHidushim(pagination: false);

    scrollController.addListener(() {
      if (!_isLoadMoreRunning && scrollController.offset >= (scrollController.position.maxScrollExtent)) {
        fetchHidushim(pagination: true);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future fetchHidushim({bool? pagination, bool? refresh}) async {
    List<Hidush> newHidushim;

    setState(() => _isLoadMoreRunning = true);

    try {
      newHidushim = await dbService.getHidushim(pagination: pagination, refresh: refresh);
      setState(() {
        if (newHidushim.isNotEmpty) {
          refresh == true ? hidushim.insertAll(0, newHidushim) : hidushim.addAll(newHidushim);
        } else {
          _hasNextPage = false;
        }

        _isLoadMoreRunning = false;
      });
    } on Exception catch (e) {
      log(e.toString());
      setState(() => _isLoadMoreRunning = false);
    }
  }

  Future<void> handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    await fetchHidushim(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticatedUser? authUser = Provider.of<AuthenticatedUser?>(context);

    return FutureBuilder(
      future: Future.wait([dbService.getUser(authUser!.uid)]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          user = snapshot.data![0];

          return RefreshIndicator(
            onRefresh: handleRefresh,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    separatorBuilder: (context, index) => const SizedBox(height: 24),
                    itemCount: hidushim.length,
                    controller: scrollController,
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
                  ),
                ),
                if (_isLoadMoreRunning)
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                // if (!_hasNextPage && scrollController.offset == scrollController.position.maxScrollExtent)
                //   Container(
                //     padding: const EdgeInsets.only(top: 24, bottom: 32),
                //     child: const Center(
                //       child: Text('שלום לך :) הגעת לסוף, בקרוב יתווספו חידושים חדשים ומחודשים'),
                //     ),
                //   ),
              ],
            ),
          );
        }
      },
    );
  }
}
