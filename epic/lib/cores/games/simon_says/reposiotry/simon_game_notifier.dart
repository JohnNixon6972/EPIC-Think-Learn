import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/game_internals/provider/game_provider.dart';
import 'package:epic/cores/games/game_internals/repository/game_service.dart';
import 'package:epic/cores/games/simon_says/model/simon_game_state.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class GameNotifier extends StateNotifier<GameState> {
  final GameService gameService;

  Ticker? _ticker;
  Duration _startTime = Duration.zero;
  late int count;

  GameNotifier(this.gameService) : super(GameState()) {
     count = (gameService.level * 3) % 10;
  }

  void startTimer() {
    _ticker = Ticker(_onTick);
    _startTime = Duration.zero;
    _ticker!.start();
  }

  void stopTimer() {
    _ticker!.stop();
    _ticker!.dispose();
    _ticker = null;
  }

  void resetTimer() {
    stopTimer();
    state = state.copyWith(elapsedTime: Duration.zero);
  }

  void generateNewCommand() {
    final random = Random();
    final shape = state.shapes[random.nextInt(count)];
    final color = state.colors[random.nextInt(state.colors.length)];
    final query = "Color the $shape ${currentColorToString(color)}";

    state = state.copyWith(
        currentShape: shape,
        currentColor: color,
        query: query,
        score: state.score! + 1,
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

  void checkUserSelection(String shape, Color color) {
    if (shape == state.currentShape && color == state.currentColor) {
      state = state.copyWith(message: "Correct! Well done!");
      generateNewCommand();
      Future.delayed(const Duration(seconds: 2), () {
        state = state.copyWith(
            message: "", backgroundColor: AppConstants.primaryBackgroundColor);
      });
    } else {
      state = state.copyWith(
          message: "Wrong! Try again!", backgroundColor: Colors.red.shade300);
      Future.delayed(const Duration(seconds: 2), () {
        state = state.copyWith(
            message: "", backgroundColor: AppConstants.primaryBackgroundColor);
      });
    }
  }

  void setBackgroundColor(Color color) {
    state = state.copyWith(backgroundColor: color);
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  final gameService = ref.read(gameServiceProvider);
  return GameNotifier(gameService);
});
