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
      floatingActionButton: SizedBox(
        height: 50,
        child: TextButton(
          style: TextButton.styleFrom(
            elevation: 5,
            shadowColor: model.strategy.color,
            backgroundColor: model.strategy.color,
            padding: const EdgeInsets.all(8),
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
              fontSize: 18,
              color: AppConstants.primaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Center(
          //   child: Image.asset(
          //     "assets/images/strategies/${model.strategy.name}.png",
          //     height: 150,
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Material(
                  elevation: 10,
                  shadowColor: model.strategy.color,
                  child: Container(
                    width: double.infinity,
                    height: 185,
                    decoration: const BoxDecoration(
                      color: AppConstants.primaryBackgroundColor,
                      // border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Completion Rate',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.primaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircularProgressBar(
                                progress: model.streak,
                                color: AppConstants.tertiaryColor,
                              ),
                              CircularProgressBar(
                                progress: model.averageAccuracy,
                                color: model.strategy.color,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Streak ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppConstants.primaryColor,
                                ),
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                color: AppConstants.tertiaryColor,
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              const Text(
                                'Accuracy ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppConstants.primaryColor,
                                ),
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                color: model.strategy.color,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Your progress in ${model.strategy.name} strategy!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: model.strategy.color,
                    // letterSpacing: 2,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                NumberBox(
                  label: 'Level',
                  value: model.level.toString(),
                  color: AppConstants.tertiaryColor,
                  icon: Icons.bar_chart_rounded,
                ),
                NumberBox(
                  label: 'Days',
                  value: model.days.toString(),
                  color: AppConstants.secondaryTextColor,
                  icon: Icons.calendar_month,
                ),
                NumberBox(
                  label: 'Streak',
                  value: model.streak.toString(),
                  color: AppConstants.tertiaryColor,
                  icon: Icons.bolt,
                ),
                NumberBox(
                  label: 'Max Streak',
                  value: model.maxStreak.toString(),
                  color: AppConstants.secondaryTextColor,
                  icon: Icons.auto_awesome,
                ),
                NumberBox(
                  label: 'Average Time',
                  value: model.averageTime.toString(),
                  color: AppConstants.tertiaryColor,
                  icon: Icons.av_timer_rounded,
                ),
                NumberBox(
                  label: 'Average Accuracy',
                  value: model.averageAccuracy.toString(),
                  color: AppConstants.secondaryTextColor,
                  icon: Icons.auto_graph_rounded,
                ),
                NumberBox(
                  label: 'Last Played',
                  value:
                      model.lastPlayed.toString().substring(0).substring(0, 10),
                  color: AppConstants.tertiaryColor,
                  icon: Icons.browse_gallery_rounded,
                ),
                NumberBox(
                  label: 'Times Played',
                  value: model.timesPlayed.toString(),
                  color: AppConstants.secondaryTextColor,
                  icon: Icons.celebration,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class HeroAnimation extends StatelessWidget {
//   const HeroAnimation({
//     super.key,
//     required this.model,
//   });

//   final StrategyModel model;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 10,
//       child: Image(
//         image: AssetImage(model.strategy.image),
//         width: 100,
//         height: 100,
//         fit: BoxFit.cover,
//       ),
//     );
//   }
// }
