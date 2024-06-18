import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/strategies/provider/strategy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StrategyDetailPage extends ConsumerWidget {
  final String strategyName;
  const StrategyDetailPage({
    required this.strategyName,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strategyAsync = ref.watch(strategyStreamProvider(strategyName));
    return strategyAsync.when(
        data: (model) {
          return Scaffold(
            backgroundColor: AppConstants.primaryBackgroundColor,
            appBar: AppBar(
              iconTheme:
                  const IconThemeData(color: AppConstants.primaryTextColor),
              title: Text(model.strategy.name,
                  style: const TextStyle(
                      color: AppConstants.primaryTextColor, fontSize: 25)),
              backgroundColor: model.strategy.color,
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
                // Add more content for the detail page below
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
                            color: AppConstants.secondayBackgroundColor,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircularProgressBar(
                                    progress: 56,
                                    color: Colors.green,
                                  ),
                                  CircularProgressBar(
                                      progress: 83,
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
                                    'Track ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
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
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    AppConstants.primaryButtonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {},
                            child: const Text(
                              "Start Activity",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        loading: () => const Loader(),
        error: (error, stack) => ErrorPage(message: error.toString()));
  }
}

class CircularProgressBar extends StatelessWidget {
  final int progress;
  final Color color;
  const CircularProgressBar({
    required this.progress,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.square(
          dimension: 90,
          child: CircularProgressIndicator(
            value: progress / 100,
            color: color,
            strokeWidth: 8.0,
          ),
        ),
        Text(
          '$progress%',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class NumberBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const NumberBox({
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      height: 130,
      width: 170,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: color),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 45, fontWeight: FontWeight.w900, color: color),
          )
        ],
      ),
    );
  }
}
