import 'package:flutter/material.dart';
import 'package:hidush/screens/favorites/favorites.dart';
import 'package:hidush/widgets/navigation/bottom_nav_bar.dart';
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

  final Map<int, dynamic> _pagess = {
    0: {'widget': Home(), 'appBarTitle': "חידוש"},
    1: {'widget': const Text('קצרים'), 'appBarTitle': "קצרים"},
    2: {'widget': const Favorites(), 'appBarTitle': "מועדפים"},
    3: {'widget': const Personal(), 'appBarTitle': "הגדרות"},
  };

  void onTabTapped(int index) {
    setState(() => _pageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          ScrollableAppBar(
            titleText: _pagess[_pageIndex]['appBarTitle'],
            context: context,
          )
        ],
        body: RefreshIndicator(
          onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
          child: _pagess[_pageIndex]['widget'],
        ),
      ),
      bottomNavigationBar: BottomNavBar(pageIndex: _pageIndex, onTap: onTabTapped),
    );
  }
}
