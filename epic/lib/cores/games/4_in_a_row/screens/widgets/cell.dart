// ignore_for_file: camel_case_types, constant_identifier_names, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/4_in_a_row/screens/widgets/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum cellMode {
  EMPTY,
  YELLOW,
  RED,
}

class Cell extends ConsumerWidget {
  final Mode;

  const Cell({
    super.key,
    required this.Mode,
  });

  Coin _buildCoin() {
    switch (Mode) {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Material(
          elevation: 10,
          child: Container(
            height: 50,
            width: 50,
            color: AppConstants.planningColor,
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: _buildCoin(),
          ),
        ),
      ],
    );
  }
}
