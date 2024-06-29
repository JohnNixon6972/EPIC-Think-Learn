import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/tea_towel/repository/tea_game_notifier.dart';
import 'package:epic/cores/games/widgets/top_panel.dart';
import 'package:epic/cores/games/widgets/winning_text.dart';
import 'package:epic/cores/widgets/celebration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeaTowelGame extends ConsumerWidget {
  const TeaTowelGame({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameNottifier = ref.read(teaGameProvider.notifier);
    final gameState = ref.watch(teaGameProvider);
    return Scaffold(
        body: Stack(
      children: [
        Visibility(
          visible: gameState.isGameWon,
          key: const Key('Confetti'),
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
                              gameNottifier.startGame();
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
                        children: [
                          TopPanel(
                            gameNotifier: gameNottifier,
                            gameState: gameState,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: gameState.currentItems.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    gameState.currentItems[index].image,
                                    width: 100,
                                    height: 100,
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
              )
      ],
    ));
  }
}
