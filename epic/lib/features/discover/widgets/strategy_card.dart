import 'package:epic/cores/app_constants.dart';
import 'package:epic/features/strategies/pages/strategy_detail_page.dart';
import 'package:epic/features/strategies/strategies.dart';
import 'package:flutter/material.dart';

class StrategyCard extends StatelessWidget {
  final Strategies strategy;
  const StrategyCard({
    required this.strategy,
    super.key,
  });

  void navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StrategyDetailPage(strategy: strategy),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToDetail(context),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9 / 2,
        decoration: BoxDecoration(
            color: strategy.color.withOpacity(0.2),
            border:
                Border.all(color: strategy.color.withOpacity(0.5), width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Hero(
              tag: 'strategy-image-${strategy.name}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10 - 2),
                child: Image(
                  height: double.infinity,
                  width: double.infinity,
                  image: AssetImage(strategy.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 4.0, left: 4.0, right: 4.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppConstants.primaryColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    strategy.name,
                    softWrap: true,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
