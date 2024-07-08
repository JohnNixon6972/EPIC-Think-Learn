import 'package:epic/cores/app_constants.dart';
import 'package:epic/features/strategies/model/strategy_model.dart';
import 'package:epic/features/strategies/provider/strategy_provider.dart';
import 'package:epic/features/strategies/widgets/circular_progress_bar.dart';
import 'package:epic/features/strategies/widgets/number_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StrategyDetail extends ConsumerWidget {
  final StrategyModel model;
  final Function(StrategyNav) changeNav;

  const StrategyDetail({
    required this.changeNav,
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppConstants.primaryBackgroundColor,
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
          Hero(
            tag: 'strategy-image-${model.strategy.name}',
            child: Image(
              image: AssetImage(model.strategy.image),
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Progress in ${model.strategy.name}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircularProgressBar(
                              progress: 56,
                              color: Colors.green,
                            ),
                            CircularProgressBar(
                                progress: 83, color: AppConstants.primaryColor),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Track ',
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
                              'Goal ',
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
