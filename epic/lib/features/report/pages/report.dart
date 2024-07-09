import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:epic/features/report/widgets/badge_view.dart';
import 'package:epic/features/report/widgets/strategy_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Report extends ConsumerWidget {
  const Report({super.key});

  static const strategies = [
    'Attention',
    'Inhibition',
    'Memory',
    'Planning',
    'Self Regulation',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserProvider).when(
        data: (currentUser) => Scaffold(
              backgroundColor: AppConstants.primaryBackgroundColor,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            const Text(
                              "My Report",
                              style: TextStyle(
                                  color: AppConstants.secondaryTextColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const BadgeView(),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Strategy Reports',
                                style: TextStyle(
                                    color: AppConstants.primaryColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            StrategyReport(strategyName: strategies[0]),
                            StrategyReport(strategyName: strategies[1]),
                            StrategyReport(strategyName: strategies[2]),
                            StrategyReport(strategyName: strategies[3]),
                            StrategyReport(strategyName: strategies[4])
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        error: (error, stackTrace) => ErrorPage(
              message: error.toString() + stackTrace.toString(),
            ),
        loading: () => const Loader());
  }
}
