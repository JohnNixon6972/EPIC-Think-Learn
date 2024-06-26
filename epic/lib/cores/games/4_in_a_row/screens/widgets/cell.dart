
import 'package:epic/cores/games/4_in_a_row/screens/widgets/coin.dart';
import 'package:flutter/material.dart';

enum cellMode {
  EMPTY,
  YELLOW,
  RED,
}

class Cell extends StatelessWidget {
  final currentCellMode;

  const Cell({
    super.key,
    required this.currentCellMode,
  });

  Coin _buildCoin() {
    switch (this.currentCellMode) {
      case cellMode.YELLOW:
        return const Coin(
          CoinColor: Colors.yellow,
        );
      case cellMode.RED:
        return const Coin(
          CoinColor: Colors.red,
        );
      default:
        return const Coin(
          CoinColor: Colors.white,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          elevation: 10,
          child: Container(
            height: 50,
            width: 50,
            color: Colors.blue,
          ),
        ),
        Positioned.fill(
          child: Align(alignment: Alignment.center, child: _buildCoin()),
        ),
      ],
    );
  }
}
