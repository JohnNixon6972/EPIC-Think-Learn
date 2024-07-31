// ignore_for_file: invalid_use_of_protected_member

import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/4_in_a_row/screens/widgets/cell.dart';
import 'package:epic/cores/games/game_internals/provider/game_provider.dart';
import 'package:epic/cores/games/game_internals/repository/game_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameController extends StateNotifier<List<List<int>>> {
  GameController(this.gameService) : super([]) {
    _buildBoard();
  }

  final GameService gameService;
  int points = 0;

  List<List<int>> get board => state;
  set board(List<List<int>> value) => state = value;

  bool _turnYellow = true;
  bool get turnYellow => _turnYellow;

  bool _isWinnerDeclared = false;
  bool get isWinnerDeclared => _isWinnerDeclared;

  List<List<int>> _winnerCells = [];
  List<List<int>> get getWinnerCells => _winnerCells;

  void _buildBoard() {
    board = List.generate(7, (_) => List.filled(6, 0));
    _turnYellow = true;
    _isWinnerDeclared = false;
    _winnerCells = [];
  }

  void incrementPoints() {
    turnYellow == false ? points += 100 : points += 0;
  }

  void incrementLevel() {
    incrementPoints();
    if (points == 500) {
      gameService.updateLevel(gameService.level + 1);
      points = 0;
    }
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
        // gameService.updateLevel(gameService.level + 1);
        incrementLevel();
        _isWinnerDeclared = true;

        debugPrint(getWinnerCells.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppConstants.secondaryColor,
            elevation: 5,
            duration: Duration(seconds: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            content: Column(
              children: [
                Text(
                  'Yellow wins!',
                  style: TextStyle(
                    color: AppConstants.primaryTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Cell(
                  Mode: cellMode.YELLOW,
                ),
              ],
            ),
          ),
        );
        Future.delayed(const Duration(seconds: 5), () {
          _buildBoard();
        });
      } else if (horizontal == 2 || vertical == 2 || diagonal == 2) {
        // gameService.updateLevel(gameService.level + 1);

        _isWinnerDeclared = true;
        debugPrint(getWinnerCells.toString());
        incrementLevel();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppConstants.primaryColor,
            elevation: 5,
            duration: Duration(seconds: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            content: Column(
              children: [
                Text(
                  'Red wins!',
                  style: TextStyle(
                    color: AppConstants.primaryTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Cell(Mode: cellMode.RED),
              ],
            ),
          ),
        );
        Future.delayed(const Duration(seconds: 5), () {
          _buildBoard();
        });
      } else {
        debugPrint(getWinnerCells.toString());
        if (isBoardFull()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppConstants.planningColor,
              elevation: 5,
              duration: Duration(seconds: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              content: Text(
                'It\'s a draw!',
                style: TextStyle(
                  color: AppConstants.primaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          );
          Future.delayed(const Duration(seconds: 5), () {
            _buildBoard();
          });
        }
      }
    } else {
      // _isWinnerDeclared = true;
      debugPrint(getWinnerCells.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppConstants.planningColor,
          elevation: 5,
          duration: Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          content: Text(
            'This column is full. Choose another column.',
            style: TextStyle(
              color: AppConstants.primaryTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      );
    }
  }

  int checkHorizontalWin() {
    List<List<int>> rows = List.generate(6, (index) => getRow(index));
    for (int rowIndex = 0; rowIndex < rows.length; rowIndex++) {
      int yellowStreak = 0;
      int redStreak = 0;
      for (int colIndex = 0; colIndex < rows[rowIndex].length; colIndex++) {
        final cell = rows[rowIndex][colIndex];
        if (cell == 1) {
          yellowStreak++;
          redStreak = 0;
          if (yellowStreak == 4) {
            _winnerCells = [
              [colIndex - 3, rowIndex],
              [colIndex - 2, rowIndex],
              [colIndex - 1, rowIndex],
              [colIndex, rowIndex]
            ];

            return 1;
          }
        } else if (cell == 2) {
          redStreak++;
          yellowStreak = 0;
          if (redStreak == 4) {
            _winnerCells = [
              [colIndex - 3, rowIndex],
              [colIndex - 2, rowIndex],
              [colIndex - 1, rowIndex],
              [colIndex, rowIndex]
            ];
            return 2;
          }
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
          if (yellowStreak == 4) {
            _winnerCells = [
              [col, row - 3],
              [col, row - 2],
              [col, row - 1],
              [col, row]
            ];
            return 1;
          }
        } else if (board[col][row] == 2) {
          redStreak++;
          yellowStreak = 0;
          if (redStreak == 4) {
            _winnerCells = [
              [col, row - 3],
              [col, row - 2],
              [col, row - 1],
              [col, row]
            ];
            return 2;
          }
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
            if (yellowStreak == 4) {
              _winnerCells = [
                [col, row],
                [col + 1, row + 1],
                [col + 2, row + 2],
                [col + 3, row + 3]
              ];
              return 1;
            }
          } else if (board[col + i][row + i] == 2) {
            redStreak++;
            yellowStreak = 0;
            if (redStreak == 4) {
              _winnerCells = [
                [col, row],
                [col + 1, row + 1],
                [col + 2, row + 2],
                [col + 3, row + 3]
              ];
              return 2;
            }
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
            if (yellowStreak == 4) {
              _winnerCells = [
                [col, row],
                [col + 1, row - 1],
                [col + 2, row - 2],
                [col + 3, row - 3]
              ];
              return 1;
            }
          } else if (board[col + i][row - i] == 2) {
            redStreak++;
            yellowStreak = 0;
            if (redStreak == 4) {
              _winnerCells = [
                [col, row],
                [col + 1, row - 1],
                [col + 2, row - 2],
                [col + 3, row - 3]
              ];
              return 2;
            }
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
  final gameService = ref.watch(gameServiceProvider);
  return GameController(gameService);
});
