import 'package:epic/cores/app_constants.dart';
import 'package:epic/features/report/widgets/badge.dart';
import 'package:flutter/material.dart';

class BadgeView extends StatelessWidget {
  const BadgeView({
    super.key,
  });

  static const List<String> badges = [
    'Attention',
    'Inhibition',
    'Memory',
    'Planning',
    'Self Regulation',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppConstants.secondaryBackgroundColor,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Badges Earned",
              style: TextStyle(
                color: AppConstants.primaryTextColor,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: AppConstants.primaryBackgroundColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: badges
                          .map((badge) => AppBadge(
                                strategyName: badge,
                              ))
                          .toList(),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
