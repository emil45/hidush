import 'package:flutter/material.dart';

import 'components/navigation_app.dart';

class CustomMateriaApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: NavigationApp(),
        ));
  }
}

void main() => runApp(CustomMateriaApp());
