import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hidush/common/utils.dart';
import 'package:hidush/models/user.dart';
import 'package:hidush/services/db.dart';
import 'package:hidush/widgets/buttons/glass_chip.dart';
import 'package:hidush/widgets/buttons/rabbi.dart';
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
  final List<List<Color>> cardsColors = [
    const [Color(0xFFB8B8FF), Color(0xFFB8EEFF)],
    const [Color(0xFFFFDAB8), Color(0xFFFFE7C2)],
    const [Color(0xFFB8FFDD), Color(0xFFC2F4FF)],
    const [Color(0xFFB9FFB8), Color(0xFFFAFFC2)],
    const [Color(0xFFB8B8FF), Color(0xFFC2C8FF)]
  ];

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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: cardsColors[math.Random().nextInt(cardsColors.length)],
          // colors: widget.categories.contains('גמרא') ? cardsColors[4] : cardsColors[0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
        child: Column(
          children: [
            const Image(image: AssetImage('assets/images/quote.png')),
            Text(
              widget.quote,
              style: const TextStyle(fontSize: 24, fontFamily: 'NotoSansHebrew', fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.source + ", " + widget.sourceDetails,
                    style: const TextStyle(fontSize: 10, fontFamily: 'NotoSansHebrew', fontWeight: FontWeight.w800),
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
                style: const TextStyle(fontFamily: 'NotoSansHebrew', fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Rabbi(rabbi: widget.rabbi, rabbiImage: widget.rabbiImage),
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
                    width: 180,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...widget.categories.map((labelText) => Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: GlassChip(text: labelText),
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
