import 'package:flutter/material.dart';

class NumberBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const NumberBox({
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      height: 130,
      width: 170,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: color),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 45, fontWeight: FontWeight.w900, color: color),
          )
        ],
      ),
    );
  }
}
