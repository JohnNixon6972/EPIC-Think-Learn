
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

class RevealAnimation extends StatefulWidget {
  final Widget child;
  const RevealAnimation({
    super.key,
    required this.child,
  });

  @override
  State<RevealAnimation> createState() => _RevealAnimationState();
}

class _RevealAnimationState extends State<RevealAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    animation.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CircularRevealAnimation(animation: animation, child: widget.child);
  }
}
