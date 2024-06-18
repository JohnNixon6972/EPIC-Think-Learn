import 'package:flutter/material.dart';
import 'package:epic/features/strategies/strategies.dart';

class StrategyDetailPage extends StatelessWidget {
  final Strategies strategy;

  const StrategyDetailPage({
    required this.strategy,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strategy.name),
        backgroundColor: strategy.color,
      ),
      body: Column(
        children: [
          Hero(
            tag: 'strategy-image-${strategy.name}',
            child: Image(
              image: AssetImage(strategy.image),
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          // Add more content for the detail page below
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Details about ${strategy.name}',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
