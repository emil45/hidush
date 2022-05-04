import 'dart:developer';
import 'dart:ui';

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
  final String upQuote = 'assets/symbols/up_quote.svg';
  final String downQuote = 'assets/symbols/down_quote.svg';

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

  Future<bool> _handleSharedPress(bool isShared) async {
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
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFB8B8FF),
            Color(0xFFE4C2FF),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
        child: Column(
          children: [
            const Image(image: AssetImage('assets/images/quote.png')),
            Text(
              widget.quote,
              style: const TextStyle(fontSize: 24, fontFamily: 'NotoSansHebrew'),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.source,
                    style: const TextStyle(fontSize: 10, fontFamily: 'NotoSansHebrew', fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    ", " + widget.sourceDetails,
                    style: const TextStyle(fontSize: 10, fontFamily: 'NotoSansHebrew', fontWeight: FontWeight.w600),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(
                      image: AssetImage(widget.rabbiImage),
                      height: 25,
                      width: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      widget.rabbi,
                      style: const TextStyle(fontSize: 12, fontFamily: 'NotoSansHebrew'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white, width: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.white, width: 0.2),
                      ),
                    ),
                    width: 200,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...widget.categories.map((labelText) => Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        color: labelsColors[labelText] ?? Colors.grey.shade200.withOpacity(0.3),
                                      ),
                                      child: Center(
                                        child: Text(
                                          labelText,
                                          style: const TextStyle(
                                              fontFamily: 'NotoSansHebrew', fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        LikeButton(
                          circleColor: CircleColor(
                            start: Colors.grey[200]!,
                            end: Colors.grey[400]!,
                          ),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Colors.grey[600]!,
                            dotSecondaryColor: Colors.grey[200]!,
                          ),
                          isLiked: null,
                          countPostion: CountPostion.left,
                          likeBuilder: ((isLiked) => const Icon(Icons.share, color: Colors.grey)),
                          likeCount: widget.shares,
                          onTap: _handleSharedPress,
                        ),
                        LikeButton(
                          isLiked: widget.isLiked,
                          countPostion: CountPostion.left,
                          likeBuilder: ((isLiked) => Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                color: isLiked ? Colors.red[300] : Colors.grey,
                              )),
                          likeCount: widget.likes,
                          onTap: _handleLikePress,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
