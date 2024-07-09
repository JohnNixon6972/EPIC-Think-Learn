// ignore_for_file: non_constant_identifier_names

import 'package:epic/cores/games/4_in_a_row/controllers/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Coin extends ConsumerWidget {
  final Color CoinColor;
  const Coin({
    super.key,
    required this.CoinColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameController = ref.watch(gameControllerProvider.notifier);

    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: CoinColor,
        borderRadius: BorderRadius.circular(32),
      ),
    );
  }
}
