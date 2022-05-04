import 'package:flutter/material.dart';
import 'package:hidush/screens/favorites/favorites.dart';
import 'package:hidush/widgets/navigation/bottom_nav_bar.dart';
import 'package:hidush/widgets/navigation/regular_app_bar.dart';
import 'package:hidush/widgets/navigation/scrollable_app_bar.dart';
import 'package:hidush/screens/home/home.dart';
import 'package:hidush/screens/personal/personal.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _pageIndex = 0;

  final Map<int, dynamic> _pages = {
    0: {'widget': Home(), 'appBarTitle': "חידושים", 'scroll': true},
    1: {'widget': const Text('קצרים'), 'appBarTitle': "קצרים", 'scroll': false},
    2: {'widget': const Favorites(), 'appBarTitle': "מועדפים", 'scroll': true},
    3: {'widget': const Personal(), 'appBarTitle': "הגדרות", 'scroll': false},
  };

  void onTabTapped(int index) {
    setState(() => _pageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    if (_pages[_pageIndex]['scroll'] == false) {
      return Scaffold(
        appBar: RegularAppBar(
          titleText: _pages[_pageIndex]['appBarTitle'],
          context: context,
        ),
        body: _pages[_pageIndex]['widget'],
        bottomNavigationBar: BottomNavBar(pageIndex: _pageIndex, onTap: onTabTapped),
      );
    }
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          ScrollableAppBar(
            titleText: _pages[_pageIndex]['appBarTitle'],
            context: context,
          )
        ],
        body: _pages[_pageIndex]['widget'],
      ),
      bottomNavigationBar: BottomNavBar(pageIndex: _pageIndex, onTap: onTabTapped),
    );
  }
}
