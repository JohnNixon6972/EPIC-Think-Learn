import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/tea_towel/model/tea_game_state.dart';
import 'package:epic/cores/games/tea_towel/repository/tea_game_notifier.dart';
import 'package:epic/cores/games/tea_towel/widgets/reveal_animation.dart';
import 'package:flutter/material.dart';

class ItemView extends StatelessWidget {
  const ItemView({
    super.key,
    required this.gameState,
    required this.gameNotifier,
  });

  final TeaGameState gameState;
  final TeaGameNotifier gameNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 8),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppConstants.primaryBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Time Left to Remember: "
              "${gameState.timeLeft} seconds",
              style: const TextStyle(
                color: AppConstants.secondaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: gameState.currentItems.length,
              itemBuilder: (context, index) {
                return RevealAnimation(
                  child: Image.asset(
                    gameState.currentItems[index].image,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: ElevatedButton(
        //     style: ButtonStyle(
        //         padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        //           const EdgeInsets.symmetric(horizontal: 8),
        //         ),
        //         backgroundColor: WidgetStateProperty.all<Color>(
        //           AppConstants.primaryButtonColor,
        //         ),
        //         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        //           RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(8),
        //           ),
        //         )),
        //     onPressed: () {
        //       gameNotifier.goToSelection();
        //     },
        //     child: const Text(
        //       "Go to Selection",
        //       style: TextStyle(
        //         color: AppConstants.primaryTextColor,
        //         fontSize: 16,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
