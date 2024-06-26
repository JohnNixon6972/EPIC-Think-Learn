import 'dart:math';

import 'package:epic/cores/games/4_in_a_row/controllers/game_controller.dart';
import 'package:epic/cores/games/4_in_a_row/screens/widgets/cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardColumn extends StatelessWidget {
  final GameController gameController = Get.find<GameController>();
  final List<int> columnOfPlayerChips;
  final int columnNumber;

  BoardColumn({
    super.key,
    required this.columnOfPlayerChips,
    required this.columnNumber,
  });

  List<Cell> _buildBoardColumn() {
    return columnOfPlayerChips.reversed
        .map((number) => number == 1
            ? const Cell(
                currentCellMode: cellMode.YELLOW,
              )
            : number == 2
                ? const Cell(
                    currentCellMode: cellMode.RED,
                  )
                : const Cell(
                    currentCellMode: cellMode.EMPTY,
                  ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        gameController.playColumn(columnNumber);
        Future.delayed(const Duration(seconds: 1), () {
          gameController.playColumn(Random().nextInt(7));
        });
      },
      child: Column(
        children: _buildBoardColumn(),
      ),
    );
  }
}
