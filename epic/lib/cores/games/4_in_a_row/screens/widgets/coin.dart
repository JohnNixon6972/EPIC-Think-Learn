// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Coin extends StatelessWidget {
  final Color CoinColor;
  const Coin({
    super.key,
    required this.CoinColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: CoinColor,
        borderRadius: BorderRadius.circular(32),
      ),
    );
  }
}
