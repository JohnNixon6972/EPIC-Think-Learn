import 'dart:async';
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
        timeLeft: _count * 5 * 2,
        // timeLeft: 5,
        currentItemNames: itemNames.toList(),
        isItemSelection: false);

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timeLeft == 0) {
        timer.cancel();
        goToSelection();
      } else {
        state = state.copyWith(timeLeft: state.timeLeft - 1);
      }
    });
  }

  void goToSelection() {
    state = state.copyWith(
      query: "Select the items you remember",
      isItemSelection: true,
    );
  }

  void selectItem(String itemName) {
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
    }
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(isGameWon: false, correctUserSelectedItems: []);
      _count = _getItemCount(gameService.level);

      generateItems();
    });
  }

  bool isCorrectItem(String itemName) {
    int index = state.correctUserSelectedItems
        .indexWhere((element) => element == itemName);

    return index != -1;
  }

  void checkItems() {
    final correctItems = state.currentItemNames;
    final userSelectedItems = state.userSelectedItems;

    List<String> correctUserSelectedItems = [];
    for(String item in state.correctUserSelectedItems){
      correctUserSelectedItems.add(item);
    }
    for (final item in userSelectedItems) {
      if (correctItems.contains(item)) {
        correctUserSelectedItems.add(item);
      }
    }

    correctUserSelectedItems = correctUserSelectedItems.toSet().toList();

    state = state.copyWith(
      correctUserSelectedItems: correctUserSelectedItems,
    );

    if (correctUserSelectedItems.length == correctItems.length) {
      state = state.copyWith(
        score: state.score + 1,
        message: "You got all correct!",
        backgroundColor: Colors.green.withOpacity(0.2),
      );
      _checkScore();
    } else {
      state = state.copyWith(
        message:
            "You got ${correctUserSelectedItems.length} out of ${correctItems.length} correct",
        backgroundColor: Colors.red.withOpacity(0.2),
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
