import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/tea_towel/repository/tea_game_notifier.dart';
import 'package:epic/cores/games/tea_towel/widgets/item_selection.dart';
import 'package:epic/cores/games/tea_towel/widgets/item_view.dart';
import 'package:epic/cores/games/widgets/end_game_button.dart';
import 'package:epic/cores/games/widgets/top_panel.dart';
import 'package:epic/cores/games/widgets/winning_text.dart';
import 'package:epic/cores/widgets/celebration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeaTowelGame extends ConsumerWidget {
  const TeaTowelGame({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameNotifier = ref.read(teaGameProvider.notifier);
    final gameState = ref.watch(teaGameProvider);
    return Scaffold(
      floatingActionButton: !gameState.isGameOver
          ? EndGameButton(endGame: gameNotifier.endGame)
          : null,
      body: Stack(
        children: [
          Visibility(
            key: const Key('Confetti'),
            visible: gameState.isGameWon,
            child: const CelebrationWidget(),
          ),
          gameState.isGameWon
              ? const Center(
                  child: WinningText(),
                )
              : AnimatedContainer(
                  color: gameState.backgroundColor,
                  duration: const Duration(milliseconds: 500),
                  child: gameState.isGameOver
                      ? SizedBox.expand(
                          child: Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      AppConstants.primaryButtonColor,
                                  padding: const EdgeInsets.all(12.0)),
                              onPressed: () {
                                gameNotifier.startGame(false);
                              },
                              child: const Text(
                                'Start Game',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TopPanel(
                              gameText: "Tea Towel: ",
                              gameNotifier: gameNotifier,
                              gameState: gameState,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            gameState.isItemSelection
                                ? ItemSelection(
                                    gameState: gameState,
                                    gameNotifier: gameNotifier)
                                : ItemView(
                                    gameState: gameState,
                                    gameNotifier: gameNotifier),
                          ],
                        ),
                )
        ],
      ),
    );
  }
}
