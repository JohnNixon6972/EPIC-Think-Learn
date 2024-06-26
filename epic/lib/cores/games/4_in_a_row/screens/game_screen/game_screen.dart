import 'package:epic/cores/games/4_in_a_row/controllers/game_controller.dart';
import 'package:epic/cores/games/4_in_a_row/screens/widgets/game_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FourInARow extends StatefulWidget {
  const FourInARow({super.key});

  @override
  State<FourInARow> createState() => _FourInARowState();
}

class _FourInARowState extends State<FourInARow> {
  final GameController gameController = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(
                gameController.turnYellow ? "Player Yellow" : "Player Red",
                style: TextStyle(
                  color: gameController.turnYellow ? Colors.yellow : Colors.red,
                ),
              )),
        ),
        body: const GameBody());
  }
}
