import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScrollableAppBar extends SliverAppBar {
  const ScrollableAppBar({Key? key})
      : super(
          key: key,
          forceElevated: true,
          floating: true,
          title: const Text(
            "חידוש",
            style: TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontFamily: 'Assistant',
                fontWeight: FontWeight.w600),
          ),
          elevation: 0.5,
          backgroundColor: Colors.white,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.black),
        );
}
