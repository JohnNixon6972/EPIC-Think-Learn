// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:epic/features/account/repository/edit_field.dart';
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

  void _onSubmit() {
    List<MapEntry<Strategies, int>> sortedStrategies =
        _strategiesToImprove.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

    // print(sortedStrategies);
    List<String> order = [];
    for (var strategy in sortedStrategies) {
      order.add(strategy.key.name);
    }

    ref.read(editSettingsProvider).editStrategy(order);

    // Save the data to the database
    // Navigate to the next page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.tertiaryColorLight,
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
                    "${widget.displayName}, let's get to know each other better!",
                    style: const TextStyle(
                      color: AppConstants.primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "Please let us know if you find it easy to do the following task:",
                      textStyle: TextStyle(
                        color: AppConstants.tertiaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
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
                                  ? AppConstants.tertiaryColor
                                  : Colors.grey,
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: _currentIndex == difficulties.length
                      ? Center(
                          child: AnimatedTextKit(
                            isRepeatingAnimation: true,
                            pause: const Duration(milliseconds: 2),
                            animatedTexts: [
                              ColorizeAnimatedText(
                                "We will tailour your experience based on your strenghts!",
                                textAlign: TextAlign.center,
                                textStyle: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                                colors: [
                                  AppConstants.secondaryColor,
                                  AppConstants.secondaryColor,
                                  AppConstants.primaryColor,
                                ],
                              ),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spring.animatedCard(
                                  fromWidth: 0,
                                  toWidth:
                                      MediaQuery.of(context).size.width - 40,
                                  fromHeight: 0,
                                  toHeight: 130,
                                  fromColor: AppConstants.primaryColor,
                                  toColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: AnimatedTextKit(
                                        isRepeatingAnimation: false,
                                        pause: const Duration(seconds: 2),
                                        animatedTexts: [
                                          ColorizeAnimatedText(
                                            difficulties[index].name,
                                            textAlign: TextAlign.center,
                                            textStyle: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            colors: [
                                              AppConstants.primaryColor,
                                              AppConstants.secondaryColor,
                                              AppConstants.secondaryColor,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                _currentIndex == difficulties.length
                                    ? Center(
                                        child: ElevatedButton(
                                          onPressed: _onSubmit,
                                          child: const Text('Complete',
                                              style: TextStyle(
                                                fontSize: 24,
                                              )),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Spring.bubbleButton(
                                            onTap:
                                                _handleYes, // Handle Yes action
                                            child: Container(
                                              height: 50,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: AppConstants
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            animDuration: Duration(seconds: 1),
                                            bubbleStart: .4,
                                            bubbleEnd: .9,
                                            curve: Curves
                                                .linear, //Curves.elasticOut
                                            delay: Duration(milliseconds: 0),
                                          ),
                                          Spring.bubbleButton(
                                            onTap:
                                                _nextPage, // Handle No action
                                            child: Container(
                                              height: 50,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'No',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: AppConstants
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            animDuration: Duration(seconds: 1),
                                            bubbleStart: .4,
                                            bubbleEnd: .9,

                                            curve: Curves
                                                .linear, //Curves.elasticOut
                                            delay: Duration(milliseconds: 0),
                                          ),
                                        ],
                                      ),
                                const SizedBox(height: 20),
                                const Text(
                                  'We can help you improve the following skills: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: AppConstants.tertiaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                for (var strategy
                                    in difficulties[index].areaOfImprovement)
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Spring.animatedCard(
                                        fromWidth: 0,
                                        toWidth:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        fromHeight: 0,
                                        fromColor: AppConstants.tertiaryColor,
                                        toColor: AppConstants.primaryColor
                                            .withOpacity(0.9),
                                        toHeight: 50,
                                        child: Center(
                                          child: Text(
                                            strategy.name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  AppConstants.secondaryColor,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
