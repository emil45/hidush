import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hidush/common/utils.dart';
import 'package:hidush/models/user.dart';
import 'package:hidush/services/db.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class HidushCard extends StatefulWidget {
  HidushCard({
    required ValueKey key,
    required this.source,
    required this.sourceDetails,
    required this.quota,
    required this.peerosh,
    required this.rabbi,
    required this.rabbiImage,
    required this.labels,
    required this.isLiked,
    required this.likes,
    required this.shares,
  }) : super(key: key);

  final String source;
  final String sourceDetails;
  final String quota;
  final String peerosh;
  final String rabbi;
  final String rabbiImage;
  final List<String> labels;
  int shares;
  int likes;
  bool isLiked;

  @override
  State<HidushCard> createState() => _HidushCardState();
}

class _HidushCardState extends State<HidushCard> {
  DBService dbService = DBService();
  IconData likeIcon = Icons.favorite;

  void _handleLikePress() async {
    final AuthenticatedUser? user = Provider.of<AuthenticatedUser?>(context, listen: false);
    await dbService.updateFavoriteHidush(user!.uid, (widget.key as ValueKey).value, !widget.isLiked);

    setState(() => widget.isLiked = !widget.isLiked);
    setState(() => widget.isLiked ? widget.likes++ : widget.likes--);
  }

  void _handleSharedPress() async {
    final AuthenticatedUser? user = Provider.of<AuthenticatedUser?>(context, listen: false);
    await dbService.updateSharedHidush(user!.uid, (widget.key as ValueKey).value);

    setState(() => widget.shares++);
  }

  @override
  Widget build(BuildContext context) {
    log("Card rendered. No: ${widget.key}");
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
              child: Text(widget.quota),
            ),
            const Divider(
              thickness: 1,
              indent: 30,
              endIndent: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(widget.peerosh),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  ...widget.labels.map((labelText) => Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Chip(
                          backgroundColor: labelsColors[labelText] ?? Colors.grey[300],
                          label: Text(labelText),
                        ),
                      ))
                ]),
                Row(
                  children: [
                    Text('${widget.shares}'),
                    IconButton(
                      onPressed: () async {
                        await Share.share('${widget.quota} (${widget.source}) \n\n ${widget.peerosh} (${widget.rabbi})',
                            subject: 'חידוש מעניין מחידוש');
                        _handleSharedPress();
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text('${widget.likes}'),
                    IconButton(
                      onPressed: _handleLikePress,
                      icon: Icon(
                        likeIcon,
                        color: Colors.blueGrey,
                      ),
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
