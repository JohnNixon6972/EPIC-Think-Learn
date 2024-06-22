import 'package:epic/cores/app_constants.dart';
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
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 20, left: 12, right: 12),
      child: GNav(
        backgroundColor: AppConstants.primaryButtonColor,
        rippleColor: AppConstants.primaryBackgroundColor,
        hoverColor: AppConstants.primaryBackgroundColor,
        haptic: true,
        tabBorderRadius: 15,
        tabActiveBorder: Border.all(
          color: AppConstants.primaryBackgroundColor,
          width: 1,
        ),
        curve: Curves.easeInToLinear,
        duration: const Duration(milliseconds: 900),
        gap: 8,
        color: AppConstants.primaryBackgroundColor,
        activeColor: AppConstants.primaryBackgroundColor,
        iconSize: 32,
        tabBackgroundColor: AppConstants.primaryButtonColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryBackgroundColor),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'HOME',
          ),
          GButton(
            icon: Icons.bar_chart,
            text: 'REPORT',
          ),
          GButton(
            icon: Icons.person,
            text: 'PROFILE',
          ),
        ],
        onTabChange: widget.onPressed,
        selectedIndex: currentIndex,
      ),
    );
  }
}
