import 'package:epic/cores/app_constants.dart';
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
        body: Column(
      children: [
        Obx(() => Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Center(
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      color: gameController.turnYellow
                          ? AppConstants.secondaryColor
                          : AppConstants.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      gameController.turnYellow
                          ? "Your turn"
                          : "Opponent's turn",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppConstants.primaryTextColor,
                        // gameController.turnYellow ? Colors.yellow : Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            )),
        const GameBody(),
      ],
    ));
  }
}
