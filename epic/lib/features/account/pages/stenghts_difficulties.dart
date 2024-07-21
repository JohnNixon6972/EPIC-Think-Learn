// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:epic/cores/app_constants.dart';
import 'package:epic/features/auth/repository/user_data_service.dart';
import 'package:epic/features/strategies/strategies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spring/spring.dart';

final formKey = GlobalKey<FormState>();

class StrenghtsDifficulties extends ConsumerStatefulWidget {
  final String displayName;
  final String profilePic;
  final String email;
  const StrenghtsDifficulties({
    super.key,
    required this.displayName,
    required this.profilePic,
    required this.email,
  });

  @override
  ConsumerState<StrenghtsDifficulties> createState() =>
      _StrenghtsDifficultiesState();
}

class _StrenghtsDifficultiesState extends ConsumerState<StrenghtsDifficulties> {
  final PageController _pageController = PageController();
  // int _currentIndex = Difficulties.values.length;
  int _currentIndex = 0;

  final Map<Strategies, int> _strategiesToImprove = {};
  final List<Difficulties> difficulties = Difficulties.values;

  void _handleYes() {
    for (var strategy in difficulties[_currentIndex].areaOfImprovement) {
      if (_strategiesToImprove.containsKey(strategy)) {
        _strategiesToImprove[strategy] = _strategiesToImprove[strategy]! + 1;
      } else {
        _strategiesToImprove[strategy] = 1;
      }
    }
    _nextPage();
  }

  void _nextPage() {
    _currentIndex++;
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {});
  }

  void _onSubmit() async {
    List<MapEntry<Strategies, int>> sortedStrategies =
        _strategiesToImprove.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

    // print(sortedStrategies);
    List<String> order = [];
    for (var strategy in sortedStrategies) {
      order.add(strategy.key.name);
    }

    // add remaining strategies
    for (var strategy in Strategies.values) {
      if (!order.contains(strategy.name)) {
        order.add(strategy.name);
      }
    }

    await ref.read(userDataServiceProvider).addUserDataToFirestore(
          strategies: order,
          username: widget.displayName,
          email: widget.email,
          profilePic: widget.profilePic,
          lastSeenStrategy: order[0],
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimateList(
              interval: 50.ms,
              effects: [
                FadeEffect(duration: 50.ms),
              ],
              children: [
                Animate(
                  effects: [
                    SlideEffect(
                      duration: 500.ms,
                    ),
                  ],
                  child: Text(
                    "Hey ${widget.displayName}, let's get to know each other better!",
                    style: const TextStyle(
                      color: AppConstants.primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < difficulties.length; i++)
                      Container(
                        margin: const EdgeInsets.all(4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == _currentIndex
                              ? AppConstants.secondaryColor
                              : i < _currentIndex
                                  ? AppConstants.primaryColor
                                  : Colors.grey,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Please let us know if you find it difficult to do the following task:",
                  style: TextStyle(
                    color: AppConstants.tertiaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  child: _currentIndex == difficulties.length
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "We will tailor your experience based on your strengths!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppConstants.tertiaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: Spring.bubbleButton(
                                  onTap: _onSubmit,
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 5,
                                    shadowColor:
                                        AppConstants.primaryButtonColor,
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: AppConstants.primaryButtonColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Let`s go!',
                                          style: TextStyle(
                                            fontSize: 22,
                                            color:
                                                AppConstants.primaryTextColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  animDuration: const Duration(seconds: 1),
                                  bubbleStart: .4,
                                  bubbleEnd: .9,
                                  curve: Curves.linear, //Curves.elasticOut
                                  delay: const Duration(milliseconds: 0),
                                ),
                              )
                            ],
                          ),
                        )
                      : PageView.builder(
                          controller: _pageController,
                          itemCount: difficulties.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  elevation: 5,
                                  color: AppConstants.tertiaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        difficulties[index].name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400,
                                          color: AppConstants.primaryTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                const Text(
                                  'We can help you improve the following skills: ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: AppConstants.tertiaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                for (var strategy
                                    in difficulties[index].areaOfImprovement)
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 50,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: strategy.name == 'Memory'
                                              ? AppConstants.memoryColor
                                              : strategy.name == 'Inhibition'
                                                  ? AppConstants.inhibitionColor
                                                  : strategy.name == 'Attention'
                                                      ? AppConstants
                                                          .attentionColor
                                                      : strategy.name ==
                                                              'Planning'
                                                          ? AppConstants
                                                              .planningColor
                                                          : AppConstants
                                                              .selfregulationColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            strategy.name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  AppConstants.primaryTextColor,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                ),
                _currentIndex != difficulties.length
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              elevation: WidgetStateProperty.all(5),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  AppConstants.primaryButtonColor),
                            ),

                            onPressed: _handleYes, // Handle Yes action

                            child: const Center(
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppConstants.primaryTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              elevation: WidgetStateProperty.all(5),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  AppConstants.primaryButtonColor),
                            ),
                            onPressed: () {
                              _nextPage();
                            }, // Handle No action
                            child: const Center(
                              child: Text(
                                'No',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppConstants.primaryTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              elevation: WidgetStateProperty.all(5),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  AppConstants.primaryButtonColor),
                            ),
                            onPressed: _nextPage, // Handle No action
                            child: const Center(
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppConstants.primaryTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const Center(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
