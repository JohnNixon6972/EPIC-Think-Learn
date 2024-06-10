import 'package:epic/features/strategies/strategies.dart';
import 'package:flutter/material.dart';

class DifficultiesScreen extends StatefulWidget {
  const DifficultiesScreen({super.key});

  @override
  _DifficultiesScreenState createState() => _DifficultiesScreenState();
}

class _DifficultiesScreenState extends State<DifficultiesScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Difficulties> difficulties = Difficulties.values;

  void _onNextPressed() {
    if (_currentIndex < difficulties.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _onPreviousPressed() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Difficulties Assessment'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentIndex + 1) / difficulties.length,
          ),
          Expanded(
            child: PageView.builder(
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
                      for (var strategy in difficulties[index].areaOfImprovement)
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _onPreviousPressed,
                child: const Text('Previous'),
              ),
              ElevatedButton(
                onPressed: () {}, // Handle Yes action
                child: const Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {}, // Handle No action
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: _onNextPressed,
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}