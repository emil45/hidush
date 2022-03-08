// Like + Share

import 'package:flutter/material.dart';

class EmoteButton extends StatelessWidget {
  final int text;
  final VoidCallback onPress;
  final IconData icon;

  const EmoteButton({Key? key, required this.text, required this.onPress, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
