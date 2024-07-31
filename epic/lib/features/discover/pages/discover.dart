import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/methods.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:epic/features/discover/widgets/ongoing_strategy_view.dart';
import 'package:epic/features/discover/widgets/strategy_view.dart';
import 'package:epic/features/discover/widgets/taskmaster_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Discover extends ConsumerStatefulWidget {
  const Discover({super.key});

  @override
  ConsumerState<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends ConsumerState<Discover> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollIndicator = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
        // You're at the top
        setState(() {
          _showScrollIndicator = true;
        });
      } else {
        // You're at the bottom
        setState(() {
          _showScrollIndicator = false;
        });
      }
    } else {
      setState(() {
        _showScrollIndicator = true;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserProvider).when(
        data: (currentUser) => Scaffold(
              backgroundColor: AppConstants.primaryBackgroundColor,
              body: SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10.0),
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            controller: _scrollController,
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
                                      fontSize: 22,
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
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppConstants.primaryColor),
                                ),
                                const TaskMasterCard()
                              ],
                            ),
                          ),
                          if (_showScrollIndicator)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                },
                                child: const Center(
                                  child: Icon(
                                    Icons.swipe_down,
                                    size: 40,
                                    color: AppConstants.primaryColor,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ))),
            ),
        error: (error, stackTrace) => ErrorPage(
              message: error.toString() + stackTrace.toString(),
            ),
        loading: () => const Loader());
  }
}
