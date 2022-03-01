import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bottom_nav_bar.dart';
import 'curved_bottom_nav_bar.dart';

class NavigationApp extends StatefulWidget {
  const NavigationApp({Key? key}) : super(key: key);

  @override
  _NavigationAppState createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  int _pageIndex = 0;
  static const List<Widget> _pages = <Widget>[
    Text(
      'בית',
    ),
    Text(
      'קצרים',
    ),
    Text(
      'מועדפים',
    ),
    Text(
      'הגדרות',
    ),
  ];

  void onTabTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: const Text(
            "חידוש",
            style: TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontFamily: 'Assistant',
                fontWeight: FontWeight.w600),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.black)),
      body: Center(child: _pages.elementAt(_pageIndex)),
      bottomNavigationBar:
          BottomNavBar(pageIndex: _pageIndex, onTap: onTabTapped),
    );
  }
}
