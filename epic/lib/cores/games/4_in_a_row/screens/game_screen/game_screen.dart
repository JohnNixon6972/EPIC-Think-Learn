import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/4_in_a_row/controllers/game_controller.dart';
import 'package:epic/cores/games/4_in_a_row/screens/widgets/game_body.dart';
import 'package:epic/cores/games/4_in_a_row/screens/widgets/levelIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FourInARow extends ConsumerWidget {
  const FourInARow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(gameControllerProvider.notifier);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants.primaryBackgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TypewriterAnimatedText(
                    '4 in a Row',
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryColor,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppConstants.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppConstants.primaryColor,
                    width: 2,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Remember to Stop and Think before every move.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppConstants.planningColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const GameBody(),
            const SizedBox(height: 20),
            const LevelIndicator(),
          ],
        ),
      ),
    );
  }
}
