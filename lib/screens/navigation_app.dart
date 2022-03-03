import 'package:flutter/material.dart';
import 'package:hidush/components/bottom_nav_bar.dart';
import 'package:hidush/components/scrollable_app_bar.dart';
import 'package:hidush/screens/home.dart';

class NavigationApp extends StatefulWidget {
  const NavigationApp({Key? key}) : super(key: key);

  @override
  _NavigationAppState createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  int _pageIndex = 0;
  static const List<Widget> _pages = <Widget>[
    Home(),
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
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) =>
            [const ScrollableAppBar()],
        body: RefreshIndicator(
          onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
          child: _pages.elementAt(_pageIndex),
        ),
      ),
      bottomNavigationBar:
          BottomNavBar(pageIndex: _pageIndex, onTap: onTabTapped),
    );
  }
}
