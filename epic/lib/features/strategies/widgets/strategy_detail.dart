import 'package:epic/cores/app_constants.dart';
import 'package:epic/features/strategies/model/strategy_model.dart';
import 'package:epic/features/strategies/provider/strategy_provider.dart';
import 'package:epic/features/strategies/widgets/circular_progress_bar.dart';
import 'package:epic/features/strategies/widgets/number_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spring/spring.dart';

class StrategyDetail extends ConsumerWidget {
  final StrategyModel model;
  final Function(StrategyNav) changeNav;

  StrategyDetail({
    required this.changeNav,
    required this.model,
    super.key,
  });

  final SpringController springController = SpringController(
    initialAnim: Motion.loop,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppConstants.tertiaryColor.withOpacity(0.1),
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          elevation: 5,
          shadowColor: AppConstants.primaryButtonColor,
          backgroundColor: AppConstants.primaryButtonColor,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          changeNav(StrategyNav.activityOverview);
        },
        child: const Text(
          'Go to Activity',
          style: TextStyle(
              fontSize: 16,
              color: AppConstants.primaryTextColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spring.rotate(
                springController: springController,
                alignment: Alignment.bottomCenter,
                startAngle: 0,
                endAngle: 360,
                curve: Curves.easeInBack,
                animDuration: const Duration(seconds: 3),
                child: HeroAnimation(model: model),
              ),
              const SizedBox(
                width: 10,
              ),
              Spring.rotate(
                alignment: Alignment.bottomCenter,
                startAngle: 360,
                endAngle: 0,
                curve: Curves.easeInBack,
                animDuration: const Duration(seconds: 3),
                child: HeroAnimation(model: model),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spring.rotate(
                alignment: Alignment.bottomCenter,
                startAngle: 0,
                endAngle: 360,
                curve: Curves.easeInBack, //def=1s
                animDuration: const Duration(seconds: 3),
                child: HeroAnimation(model: model),
              ),
              const SizedBox(
                width: 10,
              ),
              Spring.rotate(
                alignment: Alignment.bottomCenter,
                startAngle: 360,
                endAngle: 0,
                animDuration: const Duration(seconds: 3),
                curve: Curves.easeInBack,
                child: HeroAnimation(model: model),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Progress in ${model.strategy.name}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberBox(
                      label: 'Level',
                      value: model.level.toString(),
                      color: AppConstants.secondaryTextColor,
                    ),
                    NumberBox(
                      label: 'Days',
                      value: model.days.toString(),
                      color: AppConstants.secondaryBackgroundColor,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppConstants.primaryBackgroundColor,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Completion Rate',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircularProgressBar(
                              progress: model.streak,
                              color: Colors.green,
                            ),
                            CircularProgressBar(
                                progress: model.averageAccuracy,
                                color: AppConstants.primaryColor),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Streak ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Accuracy ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              color: AppConstants.primaryColor,
                            ),
                          ],
                        )
                      ],
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

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({
    super.key,
    required this.model,
  });

  final StrategyModel model;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Image(
        image: AssetImage(model.strategy.image),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
