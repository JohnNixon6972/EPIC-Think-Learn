import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/simon_says/reposiotry/simon_game_notifier.dart';
import 'package:epic/cores/games/simon_says/widgets/bottom_bar.dart';
import 'package:epic/cores/games/simon_says/widgets/shapes_panel.dart';
import 'package:epic/cores/games/simon_says/widgets/simon_says_panel.dart';
import 'package:epic/cores/widgets/celebration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimonGameScreen extends ConsumerWidget {
  const SimonGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameNotifier = ref.read(gameProvider.notifier);
    final gameState = ref.watch(gameProvider);
    return Scaffold(
      body: Stack(
        children: [
          Visibility(
            key: const Key('Confetti'),
            visible: gameState.isGameWon,
            child: const CelebrationWidget(),
          ),
          gameState.isGameWon
              ? Center(
                  child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      repeatForever: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Yaay! You Won!',
                          textStyle: const TextStyle(
                            fontSize: 30,
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ]),
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
                                gameNotifier.startGame();
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
                      : const Column(
                          key: Key('Game Column'),
                          children: [
                            SimonSaysPanel(),
                            ShapesPanel(),
                            BottomBar(),
                          ],
                        ),
                ),
        ],
      ),
    );
  }
}
