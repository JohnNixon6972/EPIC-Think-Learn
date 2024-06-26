import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';

class WinningText extends StatelessWidget {
  const WinningText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
        totalRepeatCount: 1,
        repeatForever: false,
        animatedTexts: [
          TypewriterAnimatedText(
            'Yaay! You Won!',
            textStyle: const TextStyle(
              fontSize: 30,
              color: AppConstants.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 100),
          ),
        ]);
  }
}
