import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/auth/model/user_model.dart';
import 'package:epic/features/strategies/pages/strategy_detail_page.dart';
import 'package:epic/features/strategies/provider/strategy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OngoingStrategyView extends StatelessWidget {
  final UserModel currentUser;

  const OngoingStrategyView({
    required this.currentUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final strategyAsync =
            ref.watch(strategyStreamProvider(currentUser.lastSeenStrategy));
        return strategyAsync.when(
          data: (strategy) {
            final strategyData = strategy.strategy;
            return Container(
              width: double.infinity,
              height: 125,
              decoration: BoxDecoration(
                  color: AppConstants.secondaryBackgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Current Strategy",
                      style: TextStyle(
                          fontSize: 16, color: AppConstants.primaryTextColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LinearProgressIndicator(
                      minHeight: 10,
                      value: strategy.level / 10,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation(
                          strategyData.color.withOpacity(1)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUser.lastSeenStrategy,
                          style: const TextStyle(
                              color: AppConstants.primaryTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              backgroundColor: AppConstants.primaryButtonColor,
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StrategyDetailPage(
                                  strategyName: currentUser.lastSeenStrategy,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                                color: AppConstants.primaryTextColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const Loader(),
          error: (error, stackTrace) =>
              ErrorPage(message: error.toString() + stackTrace.toString()),
        );
      },
    );
  }
}
