import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(onPressed: () {}, child: Text("Start")),
      ],
    );
  }
}
