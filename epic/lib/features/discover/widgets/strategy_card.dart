import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/strategies/pages/strategy_detail_page.dart';
import 'package:epic/features/strategies/provider/strategy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StrategyCard extends ConsumerWidget {
  final String strategyName;
  const StrategyCard({
    required this.strategyName,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strategyAsync = ref.watch(strategyStreamProvider(strategyName));
    return strategyAsync.when(
      data: (strategy) {
        final strategyData = strategy.strategy;
        return Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StrategyDetailPage(
                    strategyName: strategyName,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: strategyData.color.withOpacity(0.5),
                border: Border.all(
                  color: strategyData.color.withOpacity(0.5),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Hero(
                    tag: 'strategy-image-${strategyData.name}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        strategyData.image,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StrategyDetailPage(
                                strategyName: strategyData.name,
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppConstants.primaryButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          strategyData.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) => ErrorPage(
        message: error.toString(),
      ),
      loading: () => const Loader(),
    );
  }
}
