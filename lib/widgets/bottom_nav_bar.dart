import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(icon: Icons.home, index: 0, context: context),
          _navItem(icon: Icons.search, index: 1, context: context),
          const SizedBox(width: 40), // chừa chỗ cho FAB
          _navItem(icon: Icons.bookmark_border, index: 3, context: context),
          _navItem(icon: Icons.person_outline, index: 4, context: context),
        ],
      ),
    );
  }

  Widget _navItem({required IconData icon, required int index, required BuildContext context}) {
    return IconButton(
      onPressed: () {
        if (index == 0) {
          Navigator.pushNamed(context, '/home');
        } else if (index ==1) {
          Navigator.pushNamed(context, '/search');
        } else if (index == 3) {
          Navigator.pushNamed(context, '/bookmarks');
        } else if (index == 4) {
          Navigator.pushNamed(context, '/profile');
        }
      },
      icon: Icon(
        icon,
        color: currentIndex == index ? Colors.amber[700] : Colors.grey,
      ),
    );
  }
}
