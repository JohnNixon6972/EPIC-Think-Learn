import 'package:epic/features/auth/repository/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spring/spring.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final SpringController springController = SpringController(
    initialAnim: Motion.loop,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spring.rotate(
                  springController: springController,
                  alignment: Alignment.bottomCenter, //def=center
                  startAngle: 0, //def=0
                  endAngle: 360, //def=360
                  curve: Curves.easeInBack,
                  animDuration: const Duration(seconds: 3), //def=500m mil
                  child: const login_animation(
                    color: Colors.deepPurple,
                    icon_name: Icons.games,
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
                  curve: Curves.easeInBack,
                  animDuration: const Duration(seconds: 3),
                  child: const login_animation(
                    color: Colors.blue,
                    icon_name: Icons.note_add,
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
                  alignment: Alignment.bottomCenter, //def=center
                  startAngle: 0, //def=0
                  endAngle: 360, //def=360
                  curve: Curves.easeInBack, //def=1s
                  animDuration: const Duration(seconds: 3),
                  child: const login_animation(
                    color: Colors.blue,
                    icon_name: Icons.directions_run_outlined,
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
                  child: const login_animation(
                    color: Colors.blue,
                    icon_name: Icons.pending_actions,
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
              toShadowColor: Colors.deepPurple,
              fromWidth: MediaQuery.of(context).size.width * .48,
              toWidth: MediaQuery.of(context).size.width * .75,
              fromHeight: 60,
              toHeight: 80,
              fromColor: Colors.deepPurple.shade300,
              toColor: Colors.lightBlue.shade50,
              colorDuration: const Duration(seconds: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: Text(
                  'EPIC Think Learn',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Spring.bubbleButton(
              //optional can use gesture detector

              onTap: () {
                ref.read(authServiceProvider).signInWithGoogle();
              },
              animDuration: const Duration(seconds: 1), //def=500m mil
              bubbleStart: .4, //def=0.0
              bubbleEnd: .9, //def=1.1
              curve: Curves.linear, //Curves.elasticOut
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

// ignore: camel_case_types
class login_animation extends StatelessWidget {
  final Color color;
  final IconData icon_name;
  const login_animation({
    required this.color,
    required this.icon_name,
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
        icon_name,
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
