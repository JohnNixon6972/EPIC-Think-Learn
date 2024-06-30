import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/tea_towel/model/tea_game_state.dart';
import 'package:epic/cores/games/tea_towel/repository/tea_game_notifier.dart';
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
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                    horizontal: 8.0)
                .copyWith(bottom: 8),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppConstants
                    .primaryBackgroundColor,
                borderRadius:
                    BorderRadius.circular(8),
              ),
              child: Text(
                "Time Left to Remember: "
                "${gameState.visibleTime!.inSeconds} seconds",
                style: const TextStyle(
                  color: AppConstants
                      .secondaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount:
                    gameState.currentItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      gameNotifier.selectItem(
                          gameState
                              .currentItems[index]
                              .name);
                    },
                    child: Image.asset(
                      gameState.currentItems[index]
                          .image,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
  }
}
