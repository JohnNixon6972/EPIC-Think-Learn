import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/simon_says/reposiotry/simon_game_notifier.dart';
import 'package:epic/cores/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimonSaysPanel extends ConsumerWidget {
  const SimonSaysPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 120,
              decoration: BoxDecoration(
                color: AppConstants.secondaryBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Simon Says: ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.primaryTextColor)),
                  AnimatedTextKit(
                    totalRepeatCount: 1,
                    key: ValueKey(gameState.query),
                    animatedTexts: [
                      TypewriterAnimatedText(
                        gameState.query,
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.white),
                        speed: const Duration(milliseconds: 100),
                      )
                    ],
                    repeatForever: false,
                  ),
                  AnimatedTextKit(
                    totalRepeatCount: 1,
                    key: ValueKey(gameState.message),
                    animatedTexts: [
                      FadeAnimatedText(
                        gameState.message,
                        textStyle:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      )
                    ],
                    repeatForever: false,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color:
                          gameNotifier.gameService.strategyModel.strategy.color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Level : ${gameNotifier.gameService.level}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.primaryTextColor),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text("|",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppConstants.primaryTextColor)),
                          ),
                          Text(
                            "Duration: ${formatDuration(gameState.elapsedTime ?? const Duration(seconds: 0))}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.primaryTextColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer(
                        builder: (context, ref, child) {
                          return Text(
                            "Score : ${gameState.score}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.primaryTextColor),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
