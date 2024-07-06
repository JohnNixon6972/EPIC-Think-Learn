// ignore_for_file: unused_element

import 'package:epic/cores/games/game_internals/provider/game_provider.dart';
import 'package:epic/cores/games/how_long_is_a_minute/controllers/gameState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import '../../game_internals/repository/game_service.dart';

final gameControllerProvider =
    StateNotifierProvider<GameController, GameState>((ref) {
  final gameService = ref.watch(gameServiceProvider);
  return GameController(gameService);
});

class GameController extends StateNotifier<GameState> {
  GameController(this.gameService)
      : super(GameState(
          isRunning: false,
          elapsedTime: 0,
          points: 0,
        ));
  Timer? _timer;

  final GameService gameService;

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
      points = 50;
    } else if (guess <= 70000 && guess >= 50000) {
      points = 30; // Close guess
    } else if (guess < 50000 || guess > 70000) {
      points = 10; // Too fast
    }

    state = state.copyWith(points: state.points + points);
    updateLevel();
  }

  void resetPoints() {
    state = state.copyWith(points: 0);
  }

  void updateLevel() {
    if (state.points == 100) {
      gameService.updateLevel(gameService.level + 1);
      resetPoints();
    }
  }

  int get points => state.points;

  int get currentLevel => gameService.level;
}
