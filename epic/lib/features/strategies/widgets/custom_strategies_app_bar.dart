import 'dart:io';

import 'package:epic/cores/app_constants.dart';
import 'package:epic/features/strategies/provider/strategy_provider.dart';
import 'package:flutter/material.dart';

class CustomStrategiesAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Color color;
  final StrategyNav currentNav;
  final Function(StrategyNav) changeNav;
  const CustomStrategiesAppBar({
    required this.changeNav,
    required this.currentNav,
    required this.title,
    required this.color,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
          icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
          onPressed: () {
            switch (currentNav) {
              case StrategyNav.detail:
                Navigator.pop(context);

              case StrategyNav.activityOverview:
                changeNav(StrategyNav.detail);

              case StrategyNav.activity:
                changeNav(StrategyNav.detail);
            }
          },
        ),
        iconTheme: const IconThemeData(color: AppConstants.primaryTextColor),
        title: Text(title,
            style: const TextStyle(
                color: AppConstants.primaryTextColor, fontSize: 25)),
        backgroundColor: color);
  }
}
