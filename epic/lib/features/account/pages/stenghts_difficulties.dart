// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:epic/features/account/repository/edit_field.dart';
import 'package:epic/features/strategies/strategies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  ConsumerState<StrenghtsDifficulties> createState() => _StrenghtsDifficultiesState();
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
              child: Text(
                "Lets get to know you better ${widget.displayName}",
                style: const TextStyle(color: Colors.blueGrey, fontSize: 24),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Please select the thing you find difficult:",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
            // LinearProgressIndicator(
            //   value: (_currentIndex + 1) / difficulties.length,
            //   valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            //   backgroundColor: Colors.grey[300],
            // ),
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
                          ? Colors.green
                          : i < _currentIndex
                              ? Colors.blue
                              : Colors.grey,
                    ),
                  ),
              ],
            ),
            Expanded(
              child: _currentIndex == difficulties.length
                  ? const Center(
                      child: Text(
                        'We will tailor your experience based on your selection.',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
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
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                difficulties[index].name,
                                style: const TextStyle(fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Areas of Improvement:',
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              for (var strategy
                                  in difficulties[index].areaOfImprovement)
                                Text(
                                  strategy.name,
                                  style: const TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _handleYes, // Handle Yes action
                        child: const Text('Yes'),
                      ),
                      ElevatedButton(
                        onPressed: _nextPage, // Handle No action
                        child: const Text('No'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
