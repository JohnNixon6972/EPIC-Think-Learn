// ignore_for_file: invalid_use_of_protected_member


import 'package:epic/cores/games/4_in_a_row/screens/widgets/cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameController extends StateNotifier<List<List<int>>> {
  GameController() : super([]) {
    _buildBoard();
  }

  List<List<int>> get board => state;
  set board(List<List<int>> value) => state = value;

  bool _turnYellow = true;
  bool get turnYellow => _turnYellow;

  void _buildBoard() {
    board = List.generate(7, (_) => List.filled(6, 0));
    _turnYellow = true;
  }

  void playColumn(int playedcolNum, BuildContext context) {
    final int playerNum = _turnYellow ? 1 : 2;

    final selectedCol = board[playedcolNum];
    if (selectedCol.contains(0)) {
      final int rowIndex = selectedCol.indexWhere((cell) => cell == 0);

      selectedCol[rowIndex] = playerNum;

      final updatedBoard = [
        for (int i = 0; i < board.length; i++)
          if (i == playedcolNum) selectedCol else board[i]
      ];

      board = updatedBoard;
      _turnYellow = !_turnYellow;

      int horizontal = checkHorizontalWin();
      int vertical = checkVerticalWin();
      int diagonal = checkDiagonalWin();

      if (horizontal == 1 || vertical == 1 || diagonal == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Column(
              children: [
                Text('Yellow wins!'),
                Cell(Mode: cellMode.YELLOW),
              ],
            ),
          ),
        );
        _buildBoard();
      } else if (horizontal == 2 || vertical == 2 || diagonal == 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Column(
              children: [
                Text('Red wins!'),
                Cell(Mode: cellMode.RED),
              ],
            ),
          ),
        );
        _buildBoard();
      } else {
        if (isBoardFull()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('It\'s a draw!'),
            ),
          );
          _buildBoard();
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This column is full. Choose another column.'),
        ),
      );
    }
  }

  int checkHorizontalWin() {
    List<List<int>> rows = List.generate(6, (index) => getRow(index));
    for (final row in rows) {
      int yellowStreak = 0;
      int redStreak = 0;
      for (final cell in row) {
        if (cell == 1) {
          yellowStreak++;
          redStreak = 0;
          if (yellowStreak == 4) return 1;
        } else if (cell == 2) {
          redStreak++;
          yellowStreak = 0;
          if (redStreak == 4) return 2;
        } else {
          yellowStreak = 0;
          redStreak = 0;
        }
      }
    }
    return 0;
  }

  bool isBoardFull() {
    for (final col in board) {
      if (col.contains(0)) return false;
    }
    return true;
  }

  int checkVerticalWin() {
    for (int col = 0; col < board.length; col++) {
      int yellowStreak = 0;
      int redStreak = 0;
      for (int row = 0; row < board[col].length; row++) {
        if (board[col][row] == 1) {
          yellowStreak++;
          redStreak = 0;
          if (yellowStreak == 4) return 1;
        } else if (board[col][row] == 2) {
          redStreak++;
          yellowStreak = 0;
          if (redStreak == 4) return 2;
        } else {
          yellowStreak = 0;
          redStreak = 0;
        }
      }
    }
    return 0;
  }

  int checkDiagonalWin() {
    // Check for diagonals with a positive slope (bottom-left to top-right)
    for (int row = 0; row < board[0].length - 3; row++) {
      for (int col = 0; col < board.length - 3; col++) {
        int yellowStreak = 0;
        int redStreak = 0;
        for (int i = 0; i < 4; i++) {
          if (board[col + i][row + i] == 1) {
            yellowStreak++;
            redStreak = 0;
            if (yellowStreak == 4) return 1;
          } else if (board[col + i][row + i] == 2) {
            redStreak++;
            yellowStreak = 0;
            if (redStreak == 4) return 2;
          } else {
            yellowStreak = 0;
            redStreak = 0;
          }
        }
      }
    }

    // Check for diagonals with a negative slope (top-left to bottom-right)
    for (int row = 3; row < board[0].length; row++) {
      for (int col = 0; col < board.length - 3; col++) {
        int yellowStreak = 0;
        int redStreak = 0;
        for (int i = 0; i < 4; i++) {
          if (board[col + i][row - i] == 1) {
            yellowStreak++;
            redStreak = 0;
            if (yellowStreak == 4) return 1;
          } else if (board[col + i][row - i] == 2) {
            redStreak++;
            yellowStreak = 0;
            if (redStreak == 4) return 2;
          } else {
            yellowStreak = 0;
            redStreak = 0;
          }
        }
      }
    }

    return 0;
  }

  List<int> getRow(int rowIndex) {
    return List.generate(board.length, (colIndex) => board[colIndex][rowIndex]);
  }
}

final gameControllerProvider =
    StateNotifierProvider<GameController, List<List<int>>>((ref) {
  return GameController();
});
