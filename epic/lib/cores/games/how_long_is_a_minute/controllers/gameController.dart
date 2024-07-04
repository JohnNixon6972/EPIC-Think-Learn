import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

final gameControllerProvider =
    StateNotifierProvider<GameController, GameState>((ref) {
  return GameController();
});

class GameState {
  final bool isRunning;
  final int elapsedTime; // in milliseconds

  GameState({required this.isRunning, required this.elapsedTime});
}

class GameController extends StateNotifier<GameState> {
  GameController() : super(GameState(isRunning: false, elapsedTime: 0));
  Timer? _timer;

  void startTimer() {
    if (state.isRunning) return;

    state = GameState(isRunning: true, elapsedTime: 0);
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      state = GameState(isRunning: true, elapsedTime: state.elapsedTime + 100);
    });
  }

  void stopTimer() {
    _timer?.cancel();
    state = GameState(isRunning: false, elapsedTime: state.elapsedTime);
  }

  void resetTimer() {
    _timer?.cancel();
    state = GameState(isRunning: false, elapsedTime: 0);
  }
}
