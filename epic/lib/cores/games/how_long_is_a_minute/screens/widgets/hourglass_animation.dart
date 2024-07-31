import 'dart:math';

import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HourGlass extends StatefulWidget {
  const HourGlass({super.key});

  @override
  State<HourGlass> createState() => _HourGlassState();
}

class _HourGlassState extends State<HourGlass> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    int timeDilation =  Random().nextInt(30) + 1;
    _controller = AnimationController(
      duration: Duration(seconds: timeDilation),
      vsync: this,
    )..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpinKitPouringHourGlassRefined(
      color: AppConstants.selfregulationColor.withOpacity(0.7),
      strokeWidth: 2,
      size: MediaQuery.of(context).size.height * 0.5,
      controller: _controller,
    );
  }
}
