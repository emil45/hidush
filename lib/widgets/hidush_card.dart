import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hidush/common/utils.dart';
import 'package:hidush/models/user.dart';
import 'package:hidush/services/db.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class HidushCard extends StatefulWidget {
  HidushCard(
      {required ValueKey key,
      required this.id,
      required this.source,
      required this.sourceDetails,
      required this.quote,
      required this.peroosh,
      required this.rabbi,
      required this.rabbiImage,
      required this.categories,
      required this.isLiked,
      required this.likes,
      required this.shares,
      this.likePressed})
      : super(key: key);

  final String id, source, sourceDetails, quote, peroosh, rabbi, rabbiImage;
  final List<String> categories;
  void Function(String)? likePressed;
  int shares, likes;
  bool isLiked;

  @override
  State<HidushCard> createState() => _HidushCardState();
}

class _HidushCardState extends State<HidushCard> {
  DBService dbService = DBService();

  Future<bool> _handleLikePress(bool isLiked) async {
    log(isLiked.toString());
    final AuthenticatedUser? user = Provider.of<AuthenticatedUser?>(context, listen: false);
    await dbService.updateFavoriteHidush(user!.uid, widget.id, !isLiked);

    widget.likePressed != null ? widget.likePressed!((widget.key as ValueKey).value) : null;
    return !isLiked;
  }

  Future<bool> _handleSharedPress(bool isShared) async {
    final AuthenticatedUser? user = Provider.of<AuthenticatedUser?>(context, listen: false);

    await Share.share('${widget.quote} (${widget.source}) \n\n ${widget.peroosh} (${widget.rabbi})',
        subject: 'חידוש מעניין מחידוש');
    await dbService.updateSharedHidush(user!.uid, widget.id);

    setState(() => widget.shares++);
    return !isShared;
  }

  @override
  Widget build(BuildContext context) {
    log("Card rendered. No: ${widget.id}");

    return Card(
      key: widget.key,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.source,
                      style: const TextStyle(fontSize: 20, fontFamily: 'Assistant', fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.sourceDetails,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    )
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image(
                        image: AssetImage(widget.rabbiImage),
                        height: 45,
                        width: 45,
                      ),
                    ),
                    Text(widget.rabbi, style: const TextStyle(fontSize: 12)),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(widget.quote),
            ),
            const Divider(
              thickness: 1,
              indent: 30,
              endIndent: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(widget.peroosh),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  ...widget.categories.map((labelText) => Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Chip(
                          backgroundColor: labelsColors[labelText] ?? Colors.grey[300],
                          label: Text(labelText),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ))
                ]),
                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    LikeButton(
                      padding: const EdgeInsets.only(right: 10),
                      isLiked: widget.isLiked,
                      countPostion: CountPostion.left,
                      likeBuilder: ((isLiked) => Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red[300] : Colors.grey,
                          )),
                      likeCount: widget.likes,
                      onTap: _handleLikePress,
                    ),
                    LikeButton(
                      countPostion: CountPostion.left,
                      likeBuilder: ((isLiked) => const Icon(Icons.share, color: Colors.grey)),
                      // countBuilder: (int? count, bool isLiked, String text) {
                      //   // log(count.toString());
                      //   // widget.shares = count != null ? count++ : widget.shares;
                      //   return Text("hello");
                      // },
                      likeCount: widget.shares,
                      onTap: _handleSharedPress,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
