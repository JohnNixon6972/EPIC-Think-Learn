import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class SpinKitAnimation extends StatefulWidget {
  const SpinKitAnimation({super.key});

  @override
  State<SpinKitAnimation> createState() => _SpinKitAnimationState();
}

class _SpinKitAnimationState extends State<SpinKitAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  int timeDilation = 30;

  @override
  void initState() {
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
      color: AppConstants.selfregulationColor,
      strokeWidth: 2,
      size: MediaQuery.of(context).size.height * 0.5,
      controller: _controller,
    );
  }
}
