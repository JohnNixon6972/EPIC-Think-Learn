import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Something went wrong',
      style: TextStyle(
          color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
    ));
  }
}
