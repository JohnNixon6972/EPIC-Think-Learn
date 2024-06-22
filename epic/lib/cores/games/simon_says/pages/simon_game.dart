import 'dart:math';

import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/game_internals/provider/game_provider.dart';
import 'package:epic/cores/games/simon_says/controllers/color_tile_controller.dart';
import 'package:epic/cores/games/simon_says/model/score.dart';
import 'package:epic/cores/games/simon_says/widgets/color_tile.dart';
import 'package:epic/cores/widgets/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimonGame extends StatefulWidget {
  const SimonGame({super.key});

  @override
  State<SimonGame> createState() => _SimonGameState();
}

class _SimonGameState extends State<SimonGame> {
  static const _celebrationDuration = Duration(seconds: 5);
  static const _preCelebrationDuration = Duration(milliseconds: 500);

  bool _duringCelebration = false;

  late DateTime _startOfPlay;
  late Score _score;

  List<Color> gameSequence = [];
  List<Color> playerSequence = [];
  List<Color> colors = [];

  List<ColorTileController> controllers = [];
  List<ColorTileController> controllersToAnimate = [];
  List<ColorTile> Tiles = [];

  @override
  void initState() {
    super.initState();
    _startOfPlay = DateTime.now();
    _score = Score(
      score: 0,
      duration: Duration.zero,
    );
  }

  Future<void> _playerWon() async {
    // Compute progress and score

    await Future.delayed(_preCelebrationDuration);
    if (!mounted) return;

    setState(() {
      _duringCelebration = true;
    });

    await Future.delayed(_celebrationDuration);
    if (!mounted) return;

    // Continue game or end game
    setState(() {
      _duringCelebration = false;
    });
  }

  void playSequence() {
    for (int i = 0; i < controllersToAnimate.length; i++) {
      Future.delayed(
        Duration(seconds: i),
        () {
          controllersToAnimate[i].animate();
        },
      );
    }
  }

  void generateTiles() {
    Tiles.clear();
    for (int i = 0; i < colors.length; i++) {
      final controller = ColorTileController();
      controllers.add(controller);
      Tiles.add(
        ColorTile(
          color: colors[i],
          controller: controller,
          onTap: () {
            handlePlayerInput(colors[i]);
          },
        ),
      );
    }
  }

  void generateSequence() {
    gameSequence.clear();
    controllersToAnimate.clear();
    for (int i = 0; i < colors.length; i++) {
      int randomIndex = Random().nextInt(colors.length);
      gameSequence.add(colors[randomIndex]);
      controllersToAnimate.add(controllers[randomIndex]);
    }
  }

  void generateColors(int level) {
    gameSequence.clear();
    controllers.clear();
    colors.clear();
    for (int i = 0; i < level; i++) {
      Color randomColor = Color.fromARGB(
        255,
        Random().nextInt(128), // Red component (0-127)
        Random().nextInt(128), // Green component (0-127)
        Random().nextInt(128), // Blue component (0-127)
      );
      colors.add(randomColor);
    }
  }

  void handlePlayerInput(Color color) {
    playerSequence.add(color);

    if (playerSequence.length == gameSequence.length) {
      if (playerSequence.toString() == gameSequence.toString()) {
        // Player got the sequence right
        // Increase score
        // Increase level
        // Generate new sequence
        // Play new sequence
        _playerWon();
        SnackBar snackBar = const SnackBar(
          content: Text('You got the sequence right!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // Player got the sequence wrong
        // End game
        SnackBar snackBar = const SnackBar(
          content: Text('You got the sequence wrong!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final gameService = ref.watch(gameServiceProvider);

        // if (gameState.isGameOver) {
        //   if (!_duringCelebration) {
        //     _startOfPlay = DateTime.now();
        //     _duringCelebration = true;
        //   }

        //   if (DateTime.now().difference(_startOfPlay) >
        //       _preCelebrationDuration) {
        //     gameService.celebrate();
        //   }

        //   if (DateTime.now().difference(_startOfPlay) > _celebrationDuration) {
        //     gameService.restartGame();
        //     _duringCelebration = false;
        //   }
        // }

        return IgnorePointer(
          ignoring: _duringCelebration,
          child: Stack(
            children: [
              // Game board
              SizedBox.expand(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        generateColors(gameService.level);
                        generateTiles();
                        generateSequence();

                        Future.delayed(const Duration(seconds: 1), () {
                          playSequence();
                        });
                        setState(() {});
                      },
                      child: const Text(
                        'Play',
                        style: TextStyle(
                          color: AppConstants.secondaryTextColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Visibility(
                        visible: gameSequence.isNotEmpty,
                        child: GridView.count(
                          mainAxisSpacing: 3,
                          crossAxisSpacing: 3,
                          crossAxisCount: 3,
                          children: Tiles,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox.expand(
                child: Visibility(
                    visible: _duringCelebration,
                    child: IgnorePointer(
                      child: Confetti(
                        isStopped: !_duringCelebration,
                      ),
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
