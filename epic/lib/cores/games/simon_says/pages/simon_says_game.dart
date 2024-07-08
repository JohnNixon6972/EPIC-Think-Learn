import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/simon_says/repository/simon_game_notifier.dart';
import 'package:epic/cores/games/simon_says/widgets/shapes_panel.dart';
import 'package:epic/cores/games/widgets/end_game_button.dart';
import 'package:epic/cores/games/widgets/top_panel.dart';
import 'package:epic/cores/games/widgets/winning_text.dart';
import 'package:epic/cores/widgets/celebration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimonSaysGame extends ConsumerWidget {
  const SimonSaysGame({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameNotifier = ref.read(simonGameProvider.notifier);
    final gameState = ref.watch(simonGameProvider);
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
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      AppConstants.primaryButtonColor,
                                  padding: const EdgeInsets.all(12.0)),
                              onPressed: gameNotifier.startGame,
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
                          children: [
                            TopPanel(
                              gameText: "Simon Says: ",
                              gameNotifier: gameNotifier,
                              gameState: gameState,
                            ),
                            const ShapesPanel(),
                          ],
                        ),
                ),
        ],
      ),
    );
  }
}
