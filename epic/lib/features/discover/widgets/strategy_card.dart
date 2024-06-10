import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';

class StrategyCard extends StatelessWidget {
  final StrategyType strategy;
  const StrategyCard({
    required this.strategy,
    super.key,
  });

  String getImage(StrategyType strategy) {
    switch (strategy) {
      case StrategyType.memory:
        return AppConstants.memoryCardImage;
      case StrategyType.attention:
        return AppConstants.attentionCardImage;
      case StrategyType.inhibition:
        return AppConstants.inhibitionCardImage;
      case StrategyType.planning:
        return AppConstants.planningCardImage;
      case StrategyType.selfRegulation:
        return AppConstants.selfRegulationCardImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width * 0.9 / 2,
      decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.1),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.9 / 2,
              image: AssetImage(getImage(strategy)),
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              strategy.name,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
