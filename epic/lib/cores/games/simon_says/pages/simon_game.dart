import 'package:epic/cores/widgets/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimonGame extends StatelessWidget {
  const SimonGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        // Center(
        //   child: Text(
        //     'Simon Game',
        //     style: TextStyle(
        //       fontSize: 24,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        SizedBox.expand(
          child: Confetti(
            isStopped: false,
          ),
        ),
      ],
    );
  }
}
