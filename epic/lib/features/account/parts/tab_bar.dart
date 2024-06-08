import 'package:flutter/material.dart';

class PageTabBar extends StatelessWidget {
  const PageTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      labelStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorPadding: EdgeInsets.only(top: 12),
      tabs: [
        Tab(
          text: "Home",
        ),
        Tab(
          text: "Progress",
        ),
        Tab(
          text: "Profile",
        ),
        Tab(
          text: "Settings",
        ),
      ],
    );
  }
}
