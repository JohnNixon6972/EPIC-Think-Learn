// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:epic/cores/games/4_in_a_row/controllers/game_controller.dart';
import 'package:epic/cores/games/4_in_a_row/screens/widgets/board_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Board extends ConsumerWidget {
  const Board({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardState = ref.watch(gameControllerProvider);

    List<BoardColumn> _buildBoard() {
      int currColNum = 0;
      return boardState
          .map((boardColumn) => BoardColumn(
                chips: boardColumn,
                colNum: currColNum++,
              ))
          .toList();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildBoard(),
    );
  }
}
