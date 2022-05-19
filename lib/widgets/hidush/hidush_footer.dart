import 'package:flutter/material.dart';
import 'package:hidush/widgets/buttons/glass_chip.dart';
import 'package:like_button/like_button.dart';

class HidushFooter extends StatelessWidget {
  const HidushFooter({
    Key? key,
    required this.categories,
    required this.likes,
    required this.shares,
    required this.isLiked,
    required this.handleLikePress,
    required this.handleSharePress,
  }) : super(key: key);

  final List categories;
  final int likes;
  final int shares;
  final bool isLiked;
  final Future<bool> Function(bool) handleLikePress;
  final Future<bool> Function(bool) handleSharePress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...categories.map((labelText) => Padding(
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
                  likeCount: shares,
                  onTap: handleSharePress,
                ),
                LikeButton(
                  isLiked: isLiked,
                  countPostion: CountPostion.left,
                  likeBuilder: ((isLiked) => Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red[300] : Colors.grey,
                      )),
                  likeCount: likes,
                  onTap: handleLikePress,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
