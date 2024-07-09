import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/methods.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/strategies/provider/strategy_provider.dart';
import 'package:epic/features/strategies/widgets/circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class StrategyReport extends StatelessWidget {
  final String strategyName;
  const StrategyReport({required this.strategyName, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final strategyAsync = ref.watch(strategyStreamProvider(strategyName));

      return strategyAsync.when(
          data: (strategy) {
            final strategyData = strategy.strategy;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: strategyData.color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strategyData.name,
                        style: const TextStyle(
                          color: AppConstants.primaryTextColor,
                          fontSize: 20,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppConstants.primaryBackgroundColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                KeyValReport(
                                  label: 'Current Streak: ',
                                  value: '${strategy.streak} days',
                                ),
                                KeyValReport(
                                  label: 'Max Streak: ',
                                  value: '${strategy.streak} days',
                                ),
                                KeyValReport(
                                  label: 'Last Seen: ',
                                  value: DateFormat('dd MMM yyyy hh:mm a')
                                      .format(strategy.lastPlayed),
                                ),
                                KeyValReport(
                                  label: 'Average Session Time: ',
                                  value: formatSecondsIntoTime(
                                      strategy.averageTime),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircularProgressBar(
                                          progress: strategy.averageAccuracy,
                                          color: strategyData.color,
                                        ),
                                        const Text(
                                          'Average Accuracy',
                                          style: TextStyle(
                                            color:
                                                AppConstants.secondaryTextColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircularProgressBar(
                                          progress: strategy.timesPlayed,
                                          color: strategyData.color,
                                        ),
                                        const Text(
                                          'Times Played',
                                          style: TextStyle(
                                            color:
                                                AppConstants.secondaryTextColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => ErrorPage(
                message: error.toString() + stackTrace.toString(),
              ),
          loading: () => const Loader());
    });
  }
}

class KeyValReport extends StatelessWidget {
  final String label;
  final String value;
  const KeyValReport({
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppConstants.secondaryTextColor,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppConstants.secondaryBackgroundColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
