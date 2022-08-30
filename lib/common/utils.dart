import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Map labelsColors = {
  'תורה': Colors.purple.shade200.withOpacity(0.3),
  'גמרא': Colors.green.withOpacity(0.3),
  'אמונה': Colors.yellow.shade200.withOpacity(0.3),
  'מדרש': Colors.orange.shade200.withOpacity(0.3),
  'הלכה': Colors.red.shade200.withOpacity(0.3),
};

Map rabbiToImage = {
  'הרב מאור חי': 'assets/images/rabbi/rabbi-maor.png',
  'הרב אורי שרקי': 'assets/images/rabbi/rabbi-ouri.png',
};

Future<void> dialog(String title, String body) async {
  return showDialog<void>(
    context: navigatorKey.currentContext!,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(body),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
