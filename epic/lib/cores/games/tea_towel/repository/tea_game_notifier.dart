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
  List<bool> _isCorrect = [];

  TeaGameNotifier(this.gameService) : super(TeaGameState()) {
    _count = _getItemCount(gameService.level);
    state = state.copyWith(
        backgroundColor: AppConstants.memoryColor.withOpacity(0.2));
    _isCorrect = List.generate(state.objects.length, (index) => false);
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
    _isCorrect = List.generate(state.objects.length, (index) => false);
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
      state = state.copyWith(isGameWon: false);
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
    List<String> correctItems = [];

    // add the old correct items
    for (var item in state.correctUserSelectedItems) {
      correctItems.add(item);
    }

    for (var item in state.userSelectedItems) {
      if (state.currentItemNames.contains(item)) {
        correctItems.add(item);

        final index = state.currentItemNames.indexOf(item);
        _isCorrect[index] = true;
      }
    }
    // add unique  items
    correctItems = correctItems.toSet().toList();

    state = state.copyWith(correctUserSelectedItems: correctItems);

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
