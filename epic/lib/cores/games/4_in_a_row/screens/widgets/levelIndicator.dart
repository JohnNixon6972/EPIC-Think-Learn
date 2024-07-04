import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/4_in_a_row/controllers/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LevelIndicator extends ConsumerWidget {
  const LevelIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(gameControllerProvider.select((state) {
      final gameController = ref.read(gameControllerProvider.notifier);
      return gameController.points;
    }));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LinearPercentIndicator(
        lineHeight: 20.0,
        percent: 2 * (points / 1000),
        restartAnimation: true,
        trailing: const Icon(
          Icons.bar_chart_rounded,
          color: AppConstants.primaryColor,
          size: 30.0,
        ),
        center: Text(
          'Level Indicator',
          style: TextStyle(
            color: AppConstants.primaryTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        barRadius: const Radius.circular(10),
        backgroundColor: AppConstants.secondaryBackgroundColor,
        progressColor: AppConstants.planningColor,
      ),
    );
  }
}
