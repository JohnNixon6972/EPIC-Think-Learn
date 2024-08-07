// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopPanel extends StatelessWidget {
  final String gameText;
  final gameState;
  final gameNotifier;
  const TopPanel(
      {required this.gameText,
      required this.gameState,
      required this.gameNotifier,
      super.key});

  @override
  Widget build(BuildContext context) {
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
                  Text(gameText,
                      style: const TextStyle(
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
                      color: AppConstants.primaryBackgroundColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Level : ${gameNotifier.gameService.level}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: gameNotifier
                                  .gameService.strategyModel.strategy.color,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text("|",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: gameNotifier.gameService
                                        .strategyModel.strategy.color)),
                          ),
                          Text(
                            "Duration: ${formatDuration(gameState.elapsedTime ?? const Duration(seconds: 0))}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: gameNotifier
                                    .gameService.strategyModel.strategy.color),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: Consumer(
                        builder: (context, ref, child) {
                          return Text(
                            "Round : ${gameState.score + 1}",
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
