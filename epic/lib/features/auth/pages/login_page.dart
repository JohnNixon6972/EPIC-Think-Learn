import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:epic/features/auth/repository/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spring/spring.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({
    super.key,
  });

  final SpringController springController = SpringController(
    initialAnim: Motion.loop,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppConstants.primaryBackgroundColor,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spring.rotate(
                  springController: springController,
                  alignment: Alignment.bottomCenter,
                  startAngle: 0,
                  endAngle: 360,
                  curve: Curves.easeInBack,
                  animDuration: const Duration(seconds: 3),
                  child: const LoginAnimation(
                    color: AppConstants.selfregulationColor,
                    iconName: Icons.games,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Spring.rotate(
                  // springController: springController,
                  alignment: Alignment.bottomCenter,
                  startAngle: 360,
                  endAngle: 0,
                  curve: Curves.easeInBack,
                  animDuration: const Duration(seconds: 3),
                  child: const LoginAnimation(
                    color: AppConstants.inhibitionColor,
                    iconName: Icons.note_add,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spring.rotate(
                  // springController: springController,
                  alignment: Alignment.bottomCenter,
                  startAngle: 0,
                  endAngle: 360,
                  curve: Curves.easeInBack, //def=1s
                  animDuration: const Duration(seconds: 3),
                  child: const LoginAnimation(
                    color: AppConstants.memoryColor,
                    iconName: Icons.directions_run_outlined,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Spring.rotate(
                  // springController: springController,
                  alignment: Alignment.bottomCenter, //def=center
                  startAngle: 360, //def=0
                  endAngle: 0, //def=360
                  animDuration: const Duration(seconds: 3),
                  curve: Curves.easeInBack,
                  child: const LoginAnimation(
                    color: AppConstants.planningColor,
                    iconName: Icons.pending_actions,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Spring.animatedCard(
              toElevation: 1,
              fromElevation: 0,
              toShadowColor: AppConstants.primaryColor,
              fromWidth: MediaQuery.of(context).size.width * .48,
              toWidth: MediaQuery.of(context).size.width * .75,
              fromHeight: 60,
              toHeight: 80,
              fromColor: AppConstants.primaryColorLight,
              toColor: AppConstants.primaryColor,
              colorDuration: const Duration(seconds: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: Text(
                  'EPIC Think Learn',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppConstants.primaryTextColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            AnimatedTextKit(isRepeatingAnimation: true, animatedTexts: [
              TyperAnimatedText(
                'Get Started as',
                textStyle: const TextStyle(
                  fontSize: 24,
                  color: AppConstants.tertiaryColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
                speed: const Duration(
                  milliseconds: 100,
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spring.bubbleButton(
                  onTap: () {
                    ref.read(authServiceProvider).signInWithGoogle();
                  },
                  animDuration: const Duration(seconds: 1), //def=500m mil
                  bubbleStart: .4, //def=0.0
                  bubbleEnd: .9, //def=1.1
                  curve: Curves.linear, //Curves.elasticOut
                  child: Container(
                    height: 75,
                    width: 175,
                    decoration: BoxDecoration(
                      color: AppConstants.secondaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people,
                            color: AppConstants.primaryColor,
                            size: 30,
                          ),
                          Text(
                            'Parent',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppConstants.primaryColor,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spring.bubbleButton(
                  onTap: () {
                    ref.read(authServiceProvider).signInWithGoogle();
                  },
                  animDuration: const Duration(seconds: 1),
                  bubbleStart: .4,
                  bubbleEnd: .9,
                  curve: Curves.linear, //Curves.elasticOut
                  child: Container(
                    height: 75,
                    width: 175,
                    decoration: BoxDecoration(
                      color: AppConstants.secondaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.child_care_rounded,
                            color: AppConstants.primaryColor,
                            size: 30,
                          ),
                          Text(
                            'Child',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppConstants.primaryColor,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

// ignore: camel_case_types
class LoginAnimation extends StatelessWidget {
  final Color color;
  final IconData iconName;
  const LoginAnimation({
    required this.color,
    required this.iconName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        iconName,
        color: AppConstants.secondaryColorLight,
        size: 50,
      ),
    );
  }
}
