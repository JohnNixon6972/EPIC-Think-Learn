import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Background extends StatelessWidget {
  const Background({super.key});

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

  static const _colors = [
    AppConstants.attentionColor,
    AppConstants.inhibitionColor,
    AppConstants.memoryColor,
    AppConstants.planningColor,
    AppConstants.selfregulationColor,
  ];

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        colors: _colors.map((color) => color.withOpacity(0.8)).toList(),
        durations: _durations,
        heightPercentages: _heightPercentages,
      ),
      backgroundColor: Colors.transparent,
      size: const Size(double.infinity, double.infinity),
      waveAmplitude: 0,
    );
  }
}
