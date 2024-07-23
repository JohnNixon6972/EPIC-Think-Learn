// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:epic/cores/app_constants.dart';
import 'package:epic/features/auth/pages/backgroundAnimation.dart';
import 'package:epic/features/auth/repository/user_data_service.dart';
import 'package:epic/features/strategies/strategies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';
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
  Map<String, double> dataMap = {
    'Memory': 0,
    'Inhibition': 0,
    'Attention': 0,
    'Planning': 0,
    'Self Regulation': 0
  };

  Map<String, String> definitions = {
    'Memory':
        'Memory: Mental workspace where you\nhold and organise information for a brief\ntime.',
    'Inhibition':
        'Inhibition: Avoiding distractions,\nresisting temptation and generally\ncontrolling your responses.',
    'Attention':
        'Attention: Involves sustaining, focusing\nand dividing attention or being flexible\nin your thinking.',
    'Planning':
        'Planning: The ability to think ahead and\nconsider what you need / what should\nbe done.',
    'Self Regulation':
        'Self Regulation: Being able to recognise\nand monitor task demands and to\nrespond appropriately and flexibly.'
  };

  void _handleYes() {
    for (var strategy in difficulties[_currentIndex].areaOfImprovement) {
      if (_strategiesToImprove.containsKey(strategy)) {
        _strategiesToImprove[strategy] = _strategiesToImprove[strategy]! + 1;
        _strategiesToImprove[strategy] == null
            ? dataMap[strategy.name] = 0
            : dataMap[strategy.name] =
                _strategiesToImprove[strategy]!.toDouble();
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
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _currentIndex == difficulties.length
                        ? const Text(
                            "We will tailor your experience based on your strengths!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppConstants.secondaryBackgroundColor,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                            ),
                          )
                        : Text(
                            "Hey ${widget.displayName}, let's get to know you better!",
                            style: const TextStyle(
                              color: AppConstants.primaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
              ),
              const SizedBox(height: 20),
              _currentIndex == difficulties.length
                  ? const Center()
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Please let us know if you find it difficult to do the following task:",
                            style: TextStyle(
                              color: AppConstants.tertiaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
              Flexible(
                child: _currentIndex == difficulties.length
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PieChart(
                              dataMap: dataMap,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 1.85,
                              chartLegendSpacing: 10,
                              animationDuration: const Duration(seconds: 2),
                              emptyColor: AppConstants.secondaryColor,
                              initialAngleInDegree: 0,
                              chartValuesOptions: const ChartValuesOptions(
                                decimalPlaces: 0,
                                chartValueBackgroundColor:
                                    AppConstants.primaryTextColor,
                                chartValueStyle: TextStyle(
                                    color: AppConstants.secondaryTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                showChartValueBackground: true,
                              ),
                              legendLabels: definitions,
                              legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.bottom,
                                legendTextStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: AppConstants.primaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                                legendShape: BoxShape.rectangle,
                                showLegends: true,
                              ),
                              colorList: const [
                                AppConstants.attentionColor,
                                AppConstants.inhibitionColor,
                                AppConstants.planningColor,
                                AppConstants.memoryColor,
                                AppConstants.selfregulationColor
                              ],
                            ),
                            Center(
                              child: Spring.bubbleButton(
                                onTap: _onSubmit,
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 5,
                                  shadowColor:
                                      AppConstants.secondaryBackgroundColor,
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color:
                                          AppConstants.secondaryBackgroundColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Let`s go!',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: AppConstants.primaryTextColor,
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
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
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
                                // const SizedBox(
                                //   height: 50,
                                // ),
                                // const Text(
                                //   'We can help you improve the following skills: ',
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.w500,
                                //     color: AppConstants.tertiaryColor,
                                //   ),
                                //   textAlign: TextAlign.center,
                                // ),
                                // for (var strategy
                                //     in difficulties[index].areaOfImprovement)
                                //   Center(
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Container(
                                //         height: 50,
                                //         width: 150,
                                //         decoration: BoxDecoration(
                                //           borderRadius:
                                //               BorderRadius.circular(50),
                                //           color: strategy.name == 'Memory'
                                //               ? AppConstants.memoryColor
                                //               : strategy.name == 'Inhibition'
                                //                   ? AppConstants.inhibitionColor
                                //                   : strategy.name == 'Attention'
                                //                       ? AppConstants
                                //                           .attentionColor
                                //                       : strategy.name ==
                                //                               'Planning'
                                //                           ? AppConstants
                                //                               .planningColor
                                //                           : AppConstants
                                //                               .selfregulationColor,
                                //         ),
                                //         child: Center(
                                //           child: Text(
                                //             strategy.name,
                                //             style: const TextStyle(
                                //               fontSize: 18,
                                //               fontWeight: FontWeight.bold,
                                //               color:
                                //                   AppConstants.primaryTextColor,
                                //             ),
                                //             textAlign: TextAlign.center,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              _currentIndex != difficulties.length
                  ? Column(
                      children: [
                        Row(
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
                                  AppConstants.primaryColor,
                                ),
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
                                    AppConstants.primaryColor),
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
                                  AppConstants.primaryColor,
                                ),
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
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: const Background(),
                        ),
                      ],
                    )
                  : const Center(),
            ],
          ),
        ),
      ),
    );
  }
}
