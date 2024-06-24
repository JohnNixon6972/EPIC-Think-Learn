import 'package:epic/cores/games/simon_says/reposiotry/simon_game_notifier.dart';
import 'package:epic/cores/games/simon_says/widgets/bottom_bar.dart';
import 'package:epic/cores/games/simon_says/widgets/shapes_panel.dart';
import 'package:epic/cores/games/simon_says/widgets/simon_says_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimonGameScreen extends ConsumerWidget {
  const SimonGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backGroundColor =
        ref.watch(gameProvider.select((state) => state.backgroundColor));
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: backGroundColor,
        child: const Column(
          children: [SimonSaysPanel(), ShapesPanel(), BottomBar()],
        ),
      ),
    );
  }
}
