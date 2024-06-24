import 'package:epic/cores/games/simon_says/reposiotry/simon_game_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              ref.read(gameProvider.notifier).startGame();
            },
            child: Text("Start")),
      ],
    );
  }
}
