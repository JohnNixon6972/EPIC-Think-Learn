import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/simon_says/reposiotry/simon_game_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimonSaysPanel extends ConsumerWidget {
  const SimonSaysPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                Consumer(
                  builder: (context, ref, child) {
                    final query =
                        ref.watch(gameProvider.select((state) => state.query));
                    return AnimatedTextKit(
                      totalRepeatCount: 1,
                      key: ValueKey(query),
                      animatedTexts: [
                        TypewriterAnimatedText(
                          query,
                          textStyle: const TextStyle(
                              fontSize: 20, color: Colors.white),
                          speed: const Duration(milliseconds: 100),
                        )
                      ],
                      repeatForever: false,
                    );
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final message = ref
                        .watch(gameProvider.select((state) => state.message));
                    return AnimatedTextKit(
                      totalRepeatCount: 1,
                      key: ValueKey(message),
                      animatedTexts: [
                        FadeAnimatedText(
                          message,
                          textStyle: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        )
                      ],
                      repeatForever: false,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppConstants.primaryButtonColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final score = ref
                            .watch(gameProvider.select((state) => state.score));
                        return Text("Score : $score",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.primaryTextColor));
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
