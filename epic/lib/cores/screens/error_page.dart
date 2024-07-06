// ignore_for_file: avoid_print

import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorPage extends StatefulWidget {
  final String message;
  const ErrorPage({required this.message, super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Error Page: ${widget.message}');
    return Lottie.asset(
      'assets/animations/error.json',
      controller: _controller,
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..repeat();
      },
      repeat: true,
      animate: true,
      delegates: LottieDelegates(
        values: [
          ValueDelegate.color(
            const ['**'],
            callback: (value) => AppConstants.primaryColor,
          ),
        ],
      ),
    );
  }
}
