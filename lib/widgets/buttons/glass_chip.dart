import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

class GlassChip extends StatelessWidget {
  const GlassChip({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 30.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.pink.withOpacity(0.1), Colors.purple.withOpacity(0.1)],
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'NotoSansHebrew',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
