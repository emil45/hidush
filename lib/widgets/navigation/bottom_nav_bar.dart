import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const BottomNavBar({Key? key, required this.pageIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: pageIndex,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.blueAccent,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: "בית",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.video_camera_front,
          ),
          label: "קצרים",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_border,
          ),
          label: "מועדפים",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: "הגדרות",
        ),
      ],
      onTap: (value) => onTap(value),
    );
  }
}
