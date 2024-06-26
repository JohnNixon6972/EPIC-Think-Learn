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
        return Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          shadowColor: strategyData.color,
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
              child: Column(
                children: [
                  const Spacer(),
                  Hero(
                    tag: 'strategy-image-${strategyData.name}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset(
                          strategyData.image,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
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
                          backgroundColor: strategyData.color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.5),
                          ),
                        ),
                        child: Text(
                          strategyData.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) => ErrorPage(
        message: error.toString() + stackTrace.toString(),
      ),
      loading: () => const Loader(),
    );
  }
}
