import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CloudTextBox extends StatefulWidget {
  final String text;
  final double height, width;
  final Color strategyColor;

  final TextStyle textStyle;

  const CloudTextBox(
      {super.key,
      required this.height,
      required this.width,
      required this.strategyColor,
      required this.text,
      required this.textStyle});

  @override
  State<CloudTextBox> createState() => _CloudTextBoxState();
}

class _CloudTextBoxState extends State<CloudTextBox>
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
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: [
          Center(
            child: Lottie.asset(
              'assets/animations/cloud.json',
              controller: _controller,
              repeat: true,
              animate: true,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..repeat();
              },
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color(
                    const ['**'],
                    callback: (value) => widget.strategyColor.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: widget.height * 0.375,
              ),
              Center(
                child: SizedBox(
                  width: widget.width * 0.5,
                  child: Text(
                    widget.text,
                    softWrap: true,
                    style: widget.textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
