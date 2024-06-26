
import 'package:epic/cores/games/4_in_a_row/controllers/game_controller.dart';
import 'package:epic/cores/games/4_in_a_row/screens/widgets/boardColumn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Board extends StatelessWidget {
  final GameController gameController = Get.find<GameController>();
  //  Get.find<GameController>();

  List<BoardColumn> _buildBoard() {
    int currentColumnNumber = 0;
    return gameController.board
        .map((boardColumn) => BoardColumn(
              columnOfPlayerChips: boardColumn,
              columnNumber: currentColumnNumber++,
            ))
        .toList();
  }

  Board({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(builder: (GetxController gameController) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildBoard(),
      );
    });
  }
}
