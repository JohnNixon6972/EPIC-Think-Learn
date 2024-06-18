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
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StrategyDetailPage(strategyName: strategyName),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    color: strategy.strategy.color.withOpacity(0.5),
                    border: Border.all(
                        color: strategy.strategy.color.withOpacity(0.5),
                        width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: Stack(
                  children: [
                    Hero(
                      tag: 'strategy-image-${strategy.strategy.name}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10 - 2),
                        child: Image(
                          height: double.infinity,
                          width: double.infinity,
                          image: AssetImage(strategy.strategy.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 4.0, left: 4.0, right: 4.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StrategyDetailPage(
                                  strategyName: strategy.strategy.name,
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
                            strategy.strategy.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
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
              message: error.toString(),
            ),
        loading: () => const Loader());
  }
}
