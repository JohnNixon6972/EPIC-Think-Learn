import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Background extends StatelessWidget {
  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;
  final Color color5;
  const Background(
      {super.key,
      required this.color1,
      required this.color2,
      required this.color3,
      required this.color4,
      required this.color5});

  static const _durations = [
    4000,
    5000,
    6000,
    5000,
    4000,
  ];

  static const _heightPercentages = [
    0.1,
    0.3,
    0.5,
    0.7,
    0.8,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = [
      color1,
      color2,
      color3,
      color4,
      color5,
    ];
    return WaveWidget(
      config: CustomConfig(
        colors: colors.map((color) => color).toList(),
        durations: _durations,
        heightPercentages: _heightPercentages,
      ),
      backgroundColor: Colors.transparent,
      size: const Size(double.infinity, double.infinity),
      waveAmplitude: 0,
    );
  }
}
