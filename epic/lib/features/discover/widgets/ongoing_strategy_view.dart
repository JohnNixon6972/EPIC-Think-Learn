import 'package:epic/cores/app_constants.dart';
import 'package:epic/features/auth/model/user_model.dart';
import 'package:epic/features/strategies/strategies.dart';
import 'package:flutter/material.dart';

class OngoingStrategyView extends StatelessWidget {
  final UserModel currentUser;

  const OngoingStrategyView({
    required this.currentUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Strategies strategy = Strategies.values
        .firstWhere((element) => element.name == currentUser.lastSeenStrategy);
    return Container(
      width: double.infinity,
      height: 125,
      decoration: BoxDecoration(
          color: AppConstants.secondaryBackgroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current Strategy",
              style:
                  TextStyle(fontSize: 16, color: AppConstants.primaryTextColor),
            ),
            const SizedBox(
              height: 10,
            ),
            LinearProgressIndicator(
              minHeight: 10,
              value: 0.3,
              backgroundColor: Colors.grey.shade200,
              valueColor:
                  AlwaysStoppedAnimation(strategy.color.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentUser.lastSeenStrategy,
                  style: const TextStyle(
                      color: AppConstants.primaryTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      backgroundColor: AppConstants.primaryButtonColor,
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400)),
                  onPressed: () {},
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                        color: AppConstants.primaryTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
