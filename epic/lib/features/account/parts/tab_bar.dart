import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';

class PageTabBar extends StatelessWidget {
  const PageTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      labelStyle: TextStyle(
        color: AppConstants.primaryColor,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      indicatorColor: AppConstants.primaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorPadding: EdgeInsets.only(top: 12),
      tabs: [
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
