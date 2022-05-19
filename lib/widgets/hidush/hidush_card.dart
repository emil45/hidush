import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hidush/models/user.dart';
import 'package:hidush/services/db.dart';
import 'package:hidush/widgets/buttons/glass_chip.dart';
import 'package:hidush/widgets/buttons/rabbi.dart';
import 'package:hidush/widgets/hidush/hidush_footer.dart';
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

  Future<void> _updateLikeReferences(bool isLiked) async {
    final AuthenticatedUser? user = Provider.of<AuthenticatedUser?>(context, listen: false);
    await dbService.updateFavoriteHidush(user!.uid, widget.id, !isLiked);
    widget.isLiked = !isLiked;
    widget.likePressed != null ? widget.likePressed!((widget.key as ValueKey).value) : null;
  }

  Future<void> _updateShareRefrences() async {
    final AuthenticatedUser? user = Provider.of<AuthenticatedUser?>(context, listen: false);
    await dbService.updateSharedHidush(user!.uid, widget.id);
  }

  Future<bool> _handleLikePress(bool isLiked) async {
    log(isLiked.toString());
    _updateLikeReferences(isLiked);
    return !isLiked;
  }

  Future<bool> _handleSharePress(bool isShared) async {
    // final AuthenticatedUser? user = Provider.of<AuthenticatedUser?>(context, listen: false);

    await Share.share('${widget.quote} (${widget.source}) \n\n ${widget.peroosh} (${widget.rabbi})',
        subject: 'חידוש מעניין מחידוש');
    // await dbService.updateSharedHidush(user!.uid, widget.id);

    _updateShareRefrences();
    return !isShared;
  }

  @override
  Widget build(BuildContext context) {
    log("Card rendered. No: ${widget.id}");

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2.5),
            blurRadius: 4,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Image(image: AssetImage('assets/images/quote.png')),
            ),
            Text(
              widget.quote,
              style: const TextStyle(fontSize: 22, fontFamily: 'NotoSansHebrew', fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.source + ", " + widget.sourceDetails,
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: 'NotoSansHebrew',
                      fontWeight: FontWeight.w800,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                widget.peroosh,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'NotoSansHebrew',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Rabbi(rabbi: widget.rabbi, rabbiImage: widget.rabbiImage),
            ),
            HidushFooter(
              categories: widget.categories,
              isLiked: widget.isLiked,
              likes: widget.likes,
              shares: widget.shares,
              handleLikePress: _handleLikePress,
              handleSharePress: _handleSharePress,
            ),
          ],
        ),
      ),
    );
  }
}
