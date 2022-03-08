import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hidush/common/utils.dart';
import 'package:hidush/models/user.dart';
import 'package:hidush/services/db.dart';
import 'package:hidush/widgets/buttons/emote_button.dart';
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
  IconData likeIcon = Icons.favorite;

  void _handleLikePress() async {
    final AuthenticatedUser? user = Provider.of<AuthenticatedUser?>(context, listen: false);
    await dbService.updateFavoriteHidush(user!.uid, widget.id, !widget.isLiked);

    setState(() {
      widget.likePressed != null ? widget.likePressed!((widget.key as ValueKey).value) : null;
      widget.isLiked = !widget.isLiked;
      widget.isLiked ? widget.likes++ : widget.likes--;
    });
  }

  void _handleSharedPress() async {
    final AuthenticatedUser? user = Provider.of<AuthenticatedUser?>(context, listen: false);

    await Share.share('${widget.quote} (${widget.source}) \n\n ${widget.peroosh} (${widget.rabbi})',
        subject: 'חידוש מעניין מחידוש');
    await dbService.updateSharedHidush(user!.uid, widget.id);

    setState(() => widget.shares++);
  }

  @override
  Widget build(BuildContext context) {
    log("Card rendered. No: ${widget.id}");
    likeIcon = widget.isLiked ? Icons.favorite : Icons.favorite_border;

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
                    Image(
                      image: AssetImage(widget.rabbiImage),
                      height: 45,
                      width: 45,
                    ),
                    Text(widget.rabbi, style: const TextStyle(fontSize: 8)),
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
                  children: [
                    EmoteButton(
                      text: widget.shares,
                      icon: Icons.share,
                      onPress: _handleSharedPress,
                    ),
                    const Padding(padding: EdgeInsets.only(right: 15)),
                    EmoteButton(
                      text: widget.likes,
                      icon: likeIcon,
                      onPress: _handleLikePress,
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
