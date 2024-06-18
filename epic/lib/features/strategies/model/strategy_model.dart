import 'package:epic/features/strategies/strategies.dart';

class StrategyModel {
  final Strategies strategy;
  int level;
  int days;

  StrategyModel({
    required this.strategy,
    required this.level,
    required this.days,
  });

  factory StrategyModel.fromMap(Map<String, dynamic> map) {
    final strategy = Strategies.values
        .firstWhere((element) => element.name == map['strategy']);
    return StrategyModel(
      strategy: strategy,
      level: map['level'],
      days: map['days'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'strategy': strategy.name,
      'levels': level,
      'days': days,
    };
  }
}
