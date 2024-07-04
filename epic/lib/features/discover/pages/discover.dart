import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/methods.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:epic/features/discover/widgets/ongoing_strategy_view.dart';
import 'package:epic/features/discover/widgets/strategy_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Discover extends ConsumerWidget {
  const Discover({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserprovider).when(
        data: (currentUser) => Scaffold(
              backgroundColor: AppConstants.primaryBackgroundColor,
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${getGreetings()} ${currentUser.username.split(" ")[0]}",
                        style: const TextStyle(
                            color: AppConstants.secondaryTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OngoingStrategyView(
                        currentUser: currentUser,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Strategies",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.primaryColor),
                      ),
                      SizedBox(
                        height: 350,
                        width: MediaQuery.of(context).size.width,
                        child: StrategyView(
                          currentUser: currentUser,
                        ),
                      ),
                      const Divider(
                        color: AppConstants.secondaryBackgroundColor,
                        thickness: 1,
                      ),
                      const Text(
                        'Activities',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.primaryColor),
                      ),
                      Placeholder(
                        fallbackHeight: 200,
                        color: Colors.grey.shade300,
                      )
                    ],
                  ),
                ),
              )),
            ),
        error: (error, stackTrace) => ErrorPage(
              message: error.toString() + stackTrace.toString(),
            ),
        loading: () => const Loader());
  }
}
