import 'package:epic/features/auth/model/user_model.dart';
import 'package:epic/features/discover/widgets/strategy_card.dart';
import 'package:flutter/material.dart';

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

List<Widget> getStrategies(UserModel currentUser) {
  List<Widget> strategies = [
    StrategyCard(strategyName: currentUser.strategies[0]),
    StrategyCard(
      strategyName: currentUser.strategies[1],
    ),
    StrategyCard(
      strategyName: currentUser.strategies[2],
    ),
    StrategyCard(
      strategyName: currentUser.strategies[3],
    ),
    StrategyCard(
      strategyName: currentUser.strategies[4],
    )
  ];
  return strategies;
}
