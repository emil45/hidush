import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CurvedBottomNavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const CurvedBottomNavBar({Key? key, required this.pageIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: pageIndex,
      height: 55.0,
      items: [
        Icon(
          Icons.home,
          size: 30,
          color: pageIndex == 0 ? Colors.blue : null,
        ),
        Icon(
          Icons.video_camera_front,
          size: 30,
          color: pageIndex == 1 ? Colors.blue : null,
        ),
        Icon(
          Icons.favorite_border,
          size: 30,
          color: pageIndex == 2 ? Colors.blue : null,
        ),
        Icon(
          Icons.person,
          size: 30,
          color: pageIndex == 3 ? Colors.blue : null,
        ),
      ],
      onTap: (index) {
        onTap(index);
      },
    );
  }

}