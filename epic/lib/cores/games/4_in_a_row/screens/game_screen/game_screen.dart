import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/4_in_a_row/controllers/game_controller.dart';
import 'package:epic/cores/games/4_in_a_row/screens/widgets/game_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class FourInARow extends ConsumerWidget {
  const FourInARow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(gameControllerProvider.notifier);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.turnYellow ? "Player 1" : "Player 2"),
          backgroundColor: controller.turnYellow
              ? AppConstants.primaryColor
              : AppConstants.secondaryColor,
        ),
        body: const GameBody(),
      ),
    );
  }
}
