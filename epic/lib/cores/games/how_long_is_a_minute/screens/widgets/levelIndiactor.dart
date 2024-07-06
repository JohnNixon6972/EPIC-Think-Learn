import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/how_long_is_a_minute/controllers/gameController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LevelIndicator extends ConsumerWidget {
  const LevelIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points =
        ref.watch(gameControllerProvider.select((state) => state.points));
    // int currentLevel = gameService.level;

    final currLevel = ref.watch(gameControllerProvider.notifier);

    double levelProgress = (points % 100) / 100;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            '${(levelProgress * 100).toStringAsFixed(0)}% to next level',
            style: const TextStyle(
              color: AppConstants.selfregulationColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          LinearPercentIndicator(
            lineHeight: 20.0,
            percent: levelProgress,
            restartAnimation: true,
            trailing: const Icon(
              Icons.bar_chart_rounded,
              color: AppConstants.primaryColor,
              size: 30.0,
            ),
            center: Text(
              'Level ${currLevel.currentLevel}',
              style: TextStyle(
                color: AppConstants.secondaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            barRadius: const Radius.circular(10),
            backgroundColor: AppConstants.secondaryColorLight,
            progressColor: AppConstants.selfregulationColor,
          ),
        ],
      ),
    );
  }
}