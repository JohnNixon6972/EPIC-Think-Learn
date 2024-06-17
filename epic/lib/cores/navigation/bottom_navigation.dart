import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigation extends StatefulWidget {
  final Function(int index) onPressed;
  const BottomNavigation({required this.onPressed, super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 20, left: 12, right: 12),
      child: GNav(
        rippleColor: Colors.grey[100]!,
        hoverColor: Colors.grey[100]!,
        haptic: true,
        tabBorderRadius: 15,
        tabActiveBorder: Border.all(color: Colors.black, width: 1),
        tabShadow: [
          BoxShadow(
            blurRadius: 13,
            color: Colors.grey.withOpacity(0.25),
          )
        ],
        curve: Curves.easeInToLinear,
        duration: const Duration(milliseconds: 900),
        gap: 8,
        color: Colors.grey[800],
        activeColor: Colors.blueGrey,
        iconSize: 32,
        tabBackgroundColor: Colors.blueGrey.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.bar_chart,
            text: 'Report',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
          // GButton(
          //   icon: Icons.settings,
          //   text: 'Settings',
          // ),
        ],
        onTabChange: widget.onPressed,
        selectedIndex: currentIndex,
      ),
    );
  }
}
