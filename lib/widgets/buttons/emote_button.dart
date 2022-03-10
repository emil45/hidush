// Like + Share

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class EmoteButton extends StatelessWidget {
  final int text;
  final VoidCallback onPress;
  final IconData icon;

  const EmoteButton({Key? key, required this.text, required this.onPress, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LikeButton(likeBuilder: (bool isLiked) {
      log(isLiked.toString());
      return Icon(icon, color: isLiked ? Colors.red : Colors.grey);
    });
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onPress,
      child: Row(children: [
        Text('$text'),
        const Padding(padding: EdgeInsets.only(right: 8)),
        Icon(icon, color: Colors.blueGrey),
      ]),
    );
  }
}
