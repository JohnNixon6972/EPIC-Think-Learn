import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/game_internals/provider/game_provider.dart';
import 'package:epic/cores/games/game_internals/repository/game_service.dart';
import 'package:epic/cores/games/simon_says/model/simon_game_state.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class SimonGameNotifier extends StateNotifier<SimonGameState> {
  final GameService gameService;

  Ticker? _ticker;
  Duration _startTime = Duration.zero;
  late int _count;
  int totalQueries = 0;

  SimonGameNotifier(this.gameService) : super(SimonGameState()) {
    _count = _getShapeCount(gameService.level);
    state = state.copyWith(
        backgroundColor: AppConstants.inhibitionColor.withOpacity(0.2));
  }

  int _getShapeCount(int level) {
    int count = min(9, gameService.level);
    count < 2 ? count = 2 : count;

    return count;
  }

  void _startTimer() {
    _ticker = Ticker(_onTick);
    _startTime = Duration.zero;
    _ticker!.start();
  }

  void _stopTimer() {
    _ticker!.stop();
    _ticker!.dispose();
    _ticker = null;
  }

  void resetTimer() {
    if (_ticker != null) _stopTimer();
    state = state.copyWith(elapsedTime: Duration.zero);
  }

  void startGame() {
    resetTimer();
    state = state.copyWith(isGameOver: false);
    _startTimer();
  }

  void endGame() {
    final time = state.elapsedTime?.inSeconds;
    gameService.updateAverageTime(time!);

    _stopTimer();
    state = state.copyWith(isGameOver: true);
  }

  void generateNewCommand() {
    final random = Random();
    final shape = state.shapes[random.nextInt(_count)];
    final color = state.colors[random.nextInt(state.colors.length)];
    final query = "Color the $shape ${currentColorToString(color)}";
    final simonSays = random.nextBool();

    if (!simonSays) {
      Future.delayed(const Duration(seconds: 5), () {
        state = state.copyWith(
            message: "Well done! Simon didn't say!",
            backgroundColor: Colors.green.shade300);

        generateNewCommand();
      });
    }

    state = state.copyWith(
        currentShape: shape,
        currentColor: color,
        query: query,
        score: state.score! + 1,
        simonSays: simonSays,
        backgroundColor: Colors.green.shade300);
  }

  void _onTick(Duration elapsed) {
    state = state.copyWith(elapsedTime: _startTime + elapsed);
  }

  static String currentColorToString(Color? color) {
    if (color == Colors.red) return "red";
    if (color == Colors.blue) return "blue";
    if (color == Colors.green) return "green";
    if (color == Colors.black) return "black";
    if (color == Colors.yellow) return "yellow";
    if (color == Colors.orange) return "orange";
    if (color == Colors.pink) return "pink";
    if (color == Colors.purple) return "purple";
    if (color == Colors.brown) return "brown";

    return "unknown";
  }

  void _checkScore() {
    if (state.score! >= 5) {
      state = state.copyWith(isGameWon: true, score: 0);
      gameService.updateLevel(gameService.level + 1);

      Future.delayed(const Duration(seconds: 4), () {
        state = state.copyWith(isGameWon: false);
        _count = _getShapeCount(gameService.level);
      });
    }
  }

  int get count => _count;

  void checkUserSelection(String shape, Color color) {
    if (!state.simonSays) {
      state = state.copyWith(
          message: "Simon didn't say!", backgroundColor: Colors.red.shade300);
      Future.delayed(const Duration(seconds: 2), () {
        state = state.copyWith(
            message: "",
            backgroundColor: AppConstants.inhibitionColor.withOpacity(0.3));
      });
      return;
    }

    if (shape == state.currentShape && color == state.currentColor) {
      state = state.copyWith(message: "Correct! Well done!");
      generateNewCommand();
      _checkScore();

      Future.delayed(const Duration(seconds: 2), () {
        state = state.copyWith(
            message: "",
            backgroundColor: AppConstants.inhibitionColor.withOpacity(0.2));
      });
    } else {
      state = state.copyWith(
          message: "Wrong! Try again!", backgroundColor: Colors.red.shade300);

      Future.delayed(const Duration(seconds: 2), () {
        state = state.copyWith(
            message: "",
            backgroundColor: AppConstants.inhibitionColor.withOpacity(0.3));
      });
    }
  }

  void setBackgroundColor(Color color) {
    state = state.copyWith(backgroundColor: color);
  }
}

final simonGameProvider =
    StateNotifierProvider<SimonGameNotifier, SimonGameState>((ref) {
  final gameService = ref.watch(gameServiceProvider);
  return SimonGameNotifier(gameService);
});
