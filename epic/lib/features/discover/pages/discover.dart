import 'package:epic/cores/methods.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/auth/model/user_model.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:epic/features/discover/widgets/strategy_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Discover extends ConsumerWidget {
  const Discover({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserprovider).when(
        data: (currentUser) => Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${getGreetings()} ${currentUser.username}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 135,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.1),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Current Strategy"),
                              const Text(
                                "Memory",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              LinearProgressIndicator(
                                minHeight: 15,
                                value: 0.3,
                                backgroundColor: Colors.grey,
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.blue),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.blueGrey[200],
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () {},
                                    child: const Text(
                                      "Continue",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Strategies",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 300,
                        child: StrategyView(
                          currentUser: currentUser,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ),
        error: (error, stackTrace) => ErrorPage(
              message: error.toString(),
            ),
        loading: () => const Loader());
  }
}

class StrategyView extends StatefulWidget {
  final UserModel currentUser;
  const StrategyView({
    required this.currentUser,
    super.key,
  });

  @override
  State<StrategyView> createState() => _StrategyViewState();
}

class _StrategyViewState extends State<StrategyView> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: _currentPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 5,
      onPageChanged: (int index) {
        setState(() {
          _currentPage = index;
        });
      },
      controller: _pageController,
      itemBuilder: (context, index) {
        bool isActive = index == _currentPage;
        return Center(
          child: _buildCard(
              StrategyCard(strategyName: widget.currentUser.strategies[index]),
              isActive),
        );
      },
    );
  }
}

Widget _buildCard(Widget card, bool isActive) {
  double scaleFactor = isActive ? 1 : 0.8;
  return AnimatedContainer(
    duration: const Duration(milliseconds: 350),
    curve: Curves.easeInOut,
    transform: Matrix4.identity()..scale(scaleFactor, scaleFactor),
    child: card,
  );
}
