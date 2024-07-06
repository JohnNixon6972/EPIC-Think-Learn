class GameState {
  final bool isRunning;
  final int elapsedTime;
  final int points;
  // in milliseconds

  GameState({
    required this.isRunning,
    required this.elapsedTime,
    required this.points,
  });

  GameState copyWith({
    int? elapsedTime,
    bool? isRunning,
    int? points,
  }) {
    return GameState(
      elapsedTime: elapsedTime ?? this.elapsedTime,
      isRunning: isRunning ?? this.isRunning,
      points: points ?? this.points,
    );
  }
}
