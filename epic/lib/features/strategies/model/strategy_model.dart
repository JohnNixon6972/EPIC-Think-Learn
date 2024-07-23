import 'package:epic/features/strategies/strategies.dart';

class StrategyModel {
  final Strategies strategy;
  int level;
  int days;
  int averageTime;
  int averageAccuracy;
  DateTime lastPlayed;
  int timesPlayed;
  int streak;
  int maxStreak;

  StrategyModel({
    required this.strategy,
    required this.level,
    required this.days,
    required this.averageTime,
    required this.averageAccuracy,
    required this.lastPlayed,
    required this.timesPlayed,
    required this.streak,
    required this.maxStreak,
  });

  factory StrategyModel.fromMap(Map<String, dynamic> map) {
    final strategy = Strategies.values
        .firstWhere((element) => element.name == map['strategy']);

    return StrategyModel(
      averageTime: map['averageTime'],
      averageAccuracy: map['averageAccuracy'],
      strategy: strategy,
      level: map['levels'],
      days: map['days'],
      timesPlayed: map['timesPlayed'],
      lastPlayed: DateTime.fromMillisecondsSinceEpoch(
          map['lastPlayed'].millisecondsSinceEpoch),
      streak: map['streak'],
      maxStreak: map['maxStreak'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'strategy': strategy.name,
      'levels': level,
      'days': days,
      'averageTime': averageTime,
      'timesPlayed': timesPlayed,
      'averageAccuracy': averageAccuracy,
      'lastPlayed': lastPlayed,
      'streak': streak,
      'maxStreak': maxStreak,
    };
  }
}

