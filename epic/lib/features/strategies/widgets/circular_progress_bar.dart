import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  final int progress;
  final Color color;
  const CircularProgressBar({
    required this.progress,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.square(
          dimension: 90,
          child: CircularProgressIndicator(
            backgroundColor: color.withOpacity(0.2),
            value: progress / 100,
            color: color,
            strokeWidth: 8.0,
          ),
        ),
        Text(
          '$progress%',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
