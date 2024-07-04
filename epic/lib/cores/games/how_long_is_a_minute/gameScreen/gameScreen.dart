import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/how_long_is_a_minute/controllers/gameController.dart';
import 'package:epic/cores/games/how_long_is_a_minute/widgets/hourglassAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spring/spring.dart';

class HowLongIsAMinute extends ConsumerWidget {
  const HowLongIsAMinute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);
    final gameController = ref.read(gameControllerProvider.notifier);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Guess how long is a minute?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: AppConstants.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 30),
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

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SpinKitAnimation(),
            ),
            // Text(
            //   'Elapsed Time: ${(gameState.elapsedTime / 1000).toStringAsFixed(1)} seconds',
            //   style: TextStyle(fontSize: 24),
            // ),
            SizedBox(height: 20),
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
                    color: AppConstants.secondaryColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: AppConstants.primaryColor,
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 24,
                        color: AppConstants.selfregulationColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              )
            
            else
              ElevatedButton(
                onPressed: () {
                  gameController.stopTimer();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Time\'s Up!'),
                      content: Text(
                          'You guessed ${(gameState.elapsedTime / 1000).toStringAsFixed(1)} seconds.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            gameController.resetTimer();
                            Navigator.of(context).pop();
                          },
                          child: Text('Play Again'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Stop'),
              ),
          ],
        ),
      ),
    );
  }
}

//  Spring.bubbleButton(
//           onTap: () {},
//           animDuration: const Duration(seconds: 1), //def=500m mil
//           bubbleStart: .4, //def=0.0
//           bubbleEnd: .9, //def=1.1
//           curve: Curves.linear, //Curves.elasticOut
//           child: Container(
//             height: 75,
//             width: 175,
//             decoration: BoxDecoration(
//               color: AppConstants.secondaryColor,
//               borderRadius: BorderRadius.circular(5),
//             ),
//             child: const Center(
//               child: Text(
//                 'Stop',
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: AppConstants.primaryColor,
//                   fontWeight: FontWeight.w700,
//                   letterSpacing: 2,
//                 ),
//               ),
//             ),
//           ),
//         ),