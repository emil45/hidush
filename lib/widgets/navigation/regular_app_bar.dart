import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegularAppBar extends AppBar {
  final String titleText;
  final BuildContext context;

  RegularAppBar({Key? key, required this.titleText, required this.context})
      : super(
          key: key,
          actions: [],
          title: Text(
            titleText,
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontFamily: 'Assistant', fontWeight: FontWeight.w600),
          ),
          elevation: 0.5,
          backgroundColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.black),
        );
}
