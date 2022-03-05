import 'package:flutter/material.dart';
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

  final List<Widget> _pages = <Widget>[
    Home(),
    Text('קצרים'),
    Text('מועדפים'),
    Personal()
  ];

  void onTabTapped(int index) {
    setState(() => _pageIndex = index);
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
