// ignore_for_file: invalid_use_of_protected_member

import 'dart:math';

import 'package:epic/cores/games/4_in_a_row/screens/widgets/cell.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  RxList<List<int>> _board = RxList<List<int>>();
  List<List<int>> get board => _board.value;
  set board(List<List<int>> value) => _board.value = value;

  RxBool _turnYellow = true.obs;
  bool get turnYellow {
    return _turnYellow.value;
  }

  void _buildBoard() {
    _turnYellow.value = true;
    board = [
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
    ];
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _buildBoard();
  }

  void playColumn(int columnNumber) {
    final int playerNumber = turnYellow ? 1 : 2;

    final selectedColumn = board[columnNumber];

    if (selectedColumn.contains(0)) {
      final int rowIndex = selectedColumn.indexWhere((cell) => cell == 0);

      selectedColumn[rowIndex] = playerNumber;
      //* Switch turns
      _turnYellow.value = !_turnYellow.value;
      // print(_turnYellow.value);

      update();

      final int winner = checkVictory();
  
      if (winner != 0) {
        Get.defaultDialog(
            title: winner == 1 ? 'YOU WON' : 'OPPONENT WON',
            content: Cell(
              currentCellMode: winner == 1 ? cellMode.YELLOW : cellMode.RED,
            )).then((value) => resetGame());
      }

      if (boardIsFull()) {
        Get.defaultDialog(
            title: 'Draw! Nobody won.',
            content: const Cell(
              currentCellMode: cellMode.EMPTY,
            )).then((value) => resetGame());
      }
    } else {
      Get.snackbar('Not available',
          'This column is already filled up. Choose another column.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // void declareWinner() {
  //   Get.defaultDialog(
  //       title: winner == 1 ? 'YELLOW WON' : 'RED WON',
  //       content: Cell(
  //         currentCellMode: winner == 1 ? cellMode.YELLOW : cellMode.RED,
  //       )).then((value) => resetGame());
  // }

  void resetGame() => _buildBoard();

  bool boardIsFull() {
    for (final col in board) {
      for (final val in col) {
        if (val == 0) {
          return false;
        }
      }
    }
    return true;
  }

  int checkVictory() {
    const int maxx = 7;
    const int maxy = 6;
    List<List<int>> directions = [
      [1, 0],
      [1, -1],
      [1, 1],
      [0, 1]
    ];
    for (List<int> d in directions) {
      int dx = d[0];
      int dy = d[1];
      for (int x = 0; x < maxx; x++) {
        for (int y = 0; y < maxy; y++) {
          int lastx = (x + (3 * dx));
          int lasty = (y + (3 * dy));
          if ((((0 <= lastx) && (lastx < maxx)) && (0 <= lasty)) &&
              (lasty < maxy)) {
            int w = board[x][y];
            if ((((w != 0) && (w == board[x + dx][y + dy])) &&
                    (w == board[x + (2 * dx)][y + (2 * dy)])) &&
                (w == board[lastx][lasty])) {
              return w;
            }
          }
        }
      }
    }
    return 0;
  }
}
