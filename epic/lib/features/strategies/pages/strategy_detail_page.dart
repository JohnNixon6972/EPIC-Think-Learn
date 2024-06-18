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
            appBar: AppBar(
              title: Text(model.strategy.name),
              backgroundColor: model.strategy.color,
            ),
            body: Column(
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
                  child: Text(
                    'Details about ${model.strategy.name}',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Level:${model.level}"),
                    Text("Day: ${model.days}"),
                  ],
                )
              ],
            ),
          );
        },
        loading: () => const Loader(),
        error: (error, stack) => ErrorPage(message: error.toString()));
  }
}
