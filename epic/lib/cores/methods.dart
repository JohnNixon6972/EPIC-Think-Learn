import 'package:epic/cores/app_constants.dart';
import 'package:epic/features/auth/model/user_model.dart';
import 'package:epic/features/discover/widgets/strategy_card.dart';
import 'package:epic/features/strategies/strategies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ),
  );
}

String getGreetings() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning ⛅️';
  }
  if (hour < 17) {
    return 'Good Afternoon 🌤';
  }
  return 'Good Evening 🌙';
}

Strategies getStrategy(String strategy) {
  switch (strategy) {
    case 'Memory':
      return Strategies.memory;
    case 'Attention':
      return Strategies.attention;
    case 'Inhibition':
      return Strategies.inhibition;
    case 'Planning':
      return Strategies.planning;
    case 'Self Regulation':
      return Strategies.selfRegulation;
    default:
      return Strategies.memory;
  }
}

List<Widget> getStrategies(UserModel currentUser) {
  List<Widget> strategies = [
    StaggeredGridTile.count(
        crossAxisCellCount: 3,
        mainAxisCellCount: 3,
        child: StrategyCard(strategy: getStrategy(currentUser.strategies[0]))),
    StaggeredGridTile.count(
        crossAxisCellCount: 3,
        mainAxisCellCount: 3,
        child: StrategyCard(strategy: getStrategy(currentUser.strategies[1]))),
    StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: 3,
        child: StrategyCard(strategy: getStrategy(currentUser.strategies[2]))),
    StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: 3,
        child: StrategyCard(strategy: getStrategy(currentUser.strategies[3]))),
    StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: 3,
        child: StrategyCard(strategy: getStrategy(currentUser.strategies[4]))),
  ];
  return strategies;
}
