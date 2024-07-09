import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/strategies/provider/strategy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBadge extends StatelessWidget {
  final String strategyName;

  const AppBadge({
    required this.strategyName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final strategyAsync = ref.watch(strategyStreamProvider(strategyName));
        return strategyAsync.when(
          data: (strategy) {
            final strategyData = strategy.strategy;
            return Material(
              borderRadius: BorderRadius.circular(60),
              elevation: 10,
              shadowColor: AppConstants.primaryColor,
              child: Container(
                height: 105,
                width: 105,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: AppConstants.primaryColor, width: 8),
                    color: strategyData.color.withOpacity(1),
                    borderRadius: BorderRadius.circular(60)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      strategyName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: AppConstants.primaryTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < 5; i++)
                            Star(
                              isFilled: i < strategy.level / 2,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const Loader(),
          error: (error, stackTrace) => ErrorPage(
            message: error.toString() + stackTrace.toString(),
          ),
        );
      },
    );
  }
}

class Star extends StatelessWidget {
  final bool isFilled;
  const Star({
    required this.isFilled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      size: 16,
      isFilled ? Icons.star : Icons.star_border,
      color: AppConstants.primaryTextColor,
    );
  }
}
