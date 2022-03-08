import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScrollableAppBar extends SliverAppBar {
  final String titleText;
  final BuildContext context;

  ScrollableAppBar({Key? key, required this.titleText, required this.context})
      : super(
          key: key,
          actions: [
            IconButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('כלום'),
              )),
              icon: const Icon(Icons.adb, color: Colors.black),
            )
          ],
          forceElevated: true,
          floating: true,
          title: Text(
            titleText,
            style: const TextStyle(
                fontSize: 28, color: Colors.black, fontFamily: 'Assistant', fontWeight: FontWeight.w600),
          ),
          elevation: 0.5,
          backgroundColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.black),
        );
}
