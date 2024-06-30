import 'dart:math';

import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/game_internals/provider/game_provider.dart';
import 'package:epic/cores/games/game_internals/repository/game_service.dart';
import 'package:epic/cores/games/tea_towel/model/item.dart';
import 'package:epic/cores/games/tea_towel/model/tea_game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeaGameNotifier extends StateNotifier<TeaGameState> {
  final GameService gameService;
  late int _count;
  Duration _startTime = Duration.zero;
  Ticker? _ticker;

  TeaGameNotifier(this.gameService) : super(TeaGameState()) {
    _count = _getItemCount(gameService.level);
    state = state.copyWith(
        backgroundColor: AppConstants.memoryColor.withOpacity(0.2));
  }

  int _getItemCount(int level) {
    int count = ((gameService.level) / 5).floor();
    if (count < 1) {
      count = 5;
    }
    return count * 5 % state.objects.length;
    // return 20;
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

  void startGame(bool isRestart) {
    if (isRestart) {
      resetTimer();
    }
    state = state.copyWith(isGameOver: false);
    _count = _getItemCount(gameService.level);
    generateItems();
    _startTimer();
  }

  void endGame() {
    _stopTimer();
    state = state.copyWith(isGameOver: true);
  }

  void _onTick(Duration elapsed) {
    state = state.copyWith(elapsedTime: _startTime + elapsed);
  }

  void generateItems() {
    final random = Random();
    final items = <Item>[];
    final itemNames = <String>{}; // Use a Set to prevent duplicates

    while (items.length < _count) {
      final item = state.objects[random.nextInt(state.objects.length)];
      String name = item.name;
      if (!itemNames.contains(name)) {
        items.add(item);
        itemNames.add(item.name);
      }
    }
    state = state.copyWith(
        query: "Remember the items in the list below",
        currentItems: items,
        currentItemNames: itemNames.toList(),
        isItemSelection: false);
  }

  void selectItem(String itemName) {
    // check if the item is already selected
    if (state.userSelectedItems.contains(itemName)) {
      state = state.copyWith(
          userSelectedItems: state.userSelectedItems
              .where((element) => element != itemName)
              .toList());
    } else {
      state = state
          .copyWith(userSelectedItems: [...state.userSelectedItems, itemName]);
    }
  }

  void _checkScore() {
    if (state.score == 2) {
      state = state.copyWith(isGameWon: true, score: 0);
      gameService.updateLevel(gameService.level + 1);

      Future.delayed(const Duration(seconds: 2), () {
        state = state.copyWith(isGameWon: false);
        _count = _getItemCount(gameService.level);
        generateItems();
      });
    }
  }

  void checkItems() {
    List<String> correctItems = [];

    for (var item in state.userSelectedItems) {
      if (state.currentItemNames.contains(item)) {
        correctItems.add(item);
      }
    }

    final isCorrect = state.currentItemNames
        .every((element) => state.userSelectedItems.contains(element));
    if (isCorrect) {
      state = state.copyWith(
        message: "You got all items",
        score: state.score + 1,
        backgroundColor: Colors.green.shade300,
      );
      _checkScore();
    } else {
      state = state.copyWith(
        message: "You missed some items",
        backgroundColor: Colors.red.shade300,
      );
    }

    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(
        userSelectedItems: [],
        message: "",
        backgroundColor: AppConstants.memoryColor.withOpacity(0.2),
      );
    });
  }
}

final teaGameProvider = StateNotifierProvider<TeaGameNotifier, TeaGameState>(
  (ref) => TeaGameNotifier(ref.watch(gameServiceProvider)),
);
