import 'package:epic/cores/app_constants.dart';
import 'package:epic/features/auth/model/user_model.dart';
import 'package:epic/cores/widgets/background_animation.dart';
import 'package:flutter/material.dart';

class TopHeader extends StatelessWidget {
  final UserModel user;
  const TopHeader({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    // print(user.strategies);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.username,
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.secondaryTextColor)),
          const Text(
            "Changes made on your user name and profile picture are only reflected on this app and not on any other Google Services.",
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 14,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 170,
            width: MediaQuery.of(context).size.width,
            child: const Card(
              elevation: 10,
              child: Stack(
                children: [
                  Background(
                    color1: AppConstants.attentionColor,
                    color2: AppConstants.inhibitionColor,
                    color3: AppConstants.memoryColor,
                    color4: AppConstants.planningColor,
                    color5: AppConstants.selfregulationColor,
                  ),
                  Column(
                    children: [
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "EPIC aims to change the lens through which you see yourself and how others see and support you.",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.primaryTextColor,
                            // backgroundColor:
                            // AppConstants.primaryTextColor.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
