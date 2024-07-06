import 'package:epic/cores/games/how_long_is_a_minute/controllers/gameState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

final gameControllerProvider =
    StateNotifierProvider<GameController, GameState>((ref) {
  return GameController();
});

class GameController extends StateNotifier<GameState> {
  GameController()
      : super(GameState(isRunning: false, elapsedTime: 0, points: 0, ));
  Timer? _timer;

  void startTimer() {
    if (state.isRunning) return;

    state = GameState(isRunning: true, elapsedTime: 0, points: state.points);
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      state = GameState(
          isRunning: true,
          elapsedTime: state.elapsedTime + 100,
          points: state.points);
    });
  }

  void stopTimer() {
    _timer?.cancel();
    state = GameState(
        isRunning: false, elapsedTime: state.elapsedTime, points: state.points);
  }

  void resetTimer() {
    _timer?.cancel();
    state = GameState(isRunning: false, elapsedTime: 0, points: state.points);
  }

  void updatePoints() {
    int guess = state.elapsedTime;
    int points = 0;
    if (guess == 60000) {
      points = 20;
    } else if (guess <= 70000 && guess >= 50000) {
      points = 10; // Close guess
    } else if (guess < 50000 || guess > 70000) {
      points = 5; // Too fast
    }

    state = state.copyWith(points: state.points + points);
    print(points);
  }

  int get points => state.points;
}
