import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:epic/features/report/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Report extends ConsumerWidget {
  const Report({super.key});

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
                      Container(
                        height: 350,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppConstants.secondaryBackgroundColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Badges Earned",
                                style: TextStyle(
                                  color: AppConstants.primaryTextColor,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          AppConstants.primaryBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  width: MediaQuery.of(context).size.width,
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CustomPaint(
                                      painter: BadgePainter(
                                          strategyName: 'Strategy Name',
                                          badgeColor: Colors.green,
                                          height: 100,
                                          width: 100),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
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
