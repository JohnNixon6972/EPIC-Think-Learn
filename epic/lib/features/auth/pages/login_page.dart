import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/widgets/background_animation.dart';
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
              height: 50,
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
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Stack(
                children: [
                 const SizedBox(child: Background(
                     color1: AppConstants.attentionColor,
                    color2: AppConstants.inhibitionColor,
                    color3: AppConstants.memoryColor,
                    color4: AppConstants.planningColor,
                    color5: AppConstants.selfregulationColor,
                  )),
                  Center(
                    child: Column(
                      children: [
                        Spring.fadeIn(
                          child: const Center(
                            child: Text(
                              'EPIC Think Learn',
                              style: TextStyle(
                                fontSize: 28,
                                color: AppConstants.primaryColor,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 150,
                        ),
                        Spring.bubbleButton(
                          onTap: () {
                            ref.read(authServiceProvider).signInWithGoogle();
                          },
                          animDuration: const Duration(seconds: 1),
                          bubbleStart: .4,
                          bubbleEnd: .9,
                          curve: Curves.linear, //Curves.elasticOut

                          child: Material(
                            elevation: 19,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppConstants.tertiaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'Login/Sign Up',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppConstants.primaryTextColor,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

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
