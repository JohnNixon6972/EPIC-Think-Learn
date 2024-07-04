// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:epic/cores/games/4_in_a_row/controllers/game_controller.dart';
import 'package:epic/cores/games/4_in_a_row/screens/widgets/cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardColumn extends ConsumerWidget {
  final int colNum;
  final List<int> chips;

  const BoardColumn({
    super.key,
    required this.chips,
    required this.colNum,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameNotifier = ref.read(gameControllerProvider.notifier);
    List<Cell> _buildBoardColumn() {
      return chips.reversed
          .map((number) => number == 1
              ? const Cell(
                  Mode: cellMode.YELLOW,
                )
              : number == 2
                  ? const Cell(
                      Mode: cellMode.RED,
                    )
                  : const Cell(
                      Mode: cellMode.EMPTY,
                    ))
          .toList();
    }

    return GestureDetector(
      onTap: () {
        gameNotifier.playColumn(colNum, context);

        gameNotifier.isWinnerDeclared
            ? Future.delayed(const Duration(seconds: 1), () {
                gameNotifier.playColumn(Random().nextInt(7), context);
              })
            : null;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildBoardColumn(),
      ),
    );
  }
}
