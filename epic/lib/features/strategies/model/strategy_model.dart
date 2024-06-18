import 'package:epic/features/strategies/strategies.dart';

class StrategyModel {
  final Strategies strategy;

  StrategyModel({required this.strategy});

  Map<String, dynamic> toMap() {
    return {
      'strategy': strategy.name,
      'level': strategy.levels,
      'days': strategy.days,
    };
  }

  factory StrategyModel.fromMap(Map<String, dynamic> map) {
    return StrategyModel(
      strategy: Strategies.values
          .firstWhere((element) => element.name == map['strategy']),
    );
  }
}
