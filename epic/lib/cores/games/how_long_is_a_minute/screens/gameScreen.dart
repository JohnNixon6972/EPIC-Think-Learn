import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/how_long_is_a_minute/controllers/gameController.dart';
import 'package:epic/cores/games/how_long_is_a_minute/screens/widgets/hourglassAnimation.dart';
import 'package:epic/cores/games/how_long_is_a_minute/screens/widgets/levelIndiactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spring/spring.dart';

class HowLongIsAMinute extends ConsumerWidget {
  const HowLongIsAMinute({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);
    final gameController = ref.read(gameControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppConstants.tertiaryColorLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Guess how long is a minute?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: AppConstants.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
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
                    "My brain is learning about time.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppConstants.selfregulationColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 35, bottom: 35),
              child: HourGlass(),
            ),
            const LevelIndicator(),
            if (!gameState.isRunning)
              Spring.bubbleButton(
                onTap: () {
                  gameController.startTimer();
                },
                animDuration: const Duration(seconds: 1), //def=500m mil
                bubbleStart: .4, //def=0.0
                bubbleEnd: .9,
                //def=1.1
                curve: Curves.linear, //Curves.elasticOut
                child: Container(
                  height: 65,
                  width: 175,
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppConstants.primaryColor,
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '⏱️ START',
                      style: TextStyle(
                        fontSize: 24,
                        color: AppConstants.primaryTextColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              )
            else
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: AppConstants.primaryColor,
                  shadowColor: AppConstants.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  gameController.stopTimer();
                  gameController.updatePoints();

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppConstants.primaryBackgroundColor,
                      icon: const Icon(
                        Icons.timer_off_rounded,
                        color: AppConstants.selfregulationColor,
                        size: 30,
                      ),
                      elevation: 5,
                      shadowColor: AppConstants.primaryBackgroundColor,
                      title: const Center(
                        child: Text(
                          'Time\'s Up!',
                          style: TextStyle(
                            color: AppConstants.selfregulationColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      content: SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            Text(
                              'You guessed ${(gameState.elapsedTime / 1000).toStringAsFixed(1)} seconds.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppConstants.selfregulationColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (gameState.elapsedTime <= 70000 &&
                                gameState.elapsedTime >= 50000)
                              const Text(
                                'You are were so close!⏰',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppConstants.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            else if (gameState.elapsedTime < 60000)
                              const Text(
                                'You were too fast!🚀',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppConstants.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            else if (gameState.elapsedTime > 60000)
                              const Text(
                                'You were too slow!🐢',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppConstants.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            else
                              const Text(
                                'Yay, you were right on time!🎉',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppConstants.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),
                      actions: [
                        Center(
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppConstants.secondaryColor,
                              shadowColor: AppConstants.secondaryColor,
                              elevation: 5,
                            ),
                            onPressed: () {
                              gameController.resetTimer();
                              Navigator.of(context).pop();
                            },
                            child: const SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.replay_rounded,
                                    color: AppConstants.primaryTextColor,
                                    size: 30,
                                  ),
                                  Text(
                                    'Try Again',
                                    style: TextStyle(
                                      color: AppConstants.primaryTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                //Curves.elasticOut
                child: Container(
                  height: 65,
                  width: 125,
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppConstants.primaryColor,
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '⏰ STOP',
                      style: TextStyle(
                        fontSize: 24,
                        color: AppConstants.primaryTextColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
