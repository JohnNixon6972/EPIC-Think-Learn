import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  const ErrorPage({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Something went wrong : $message',
      style: const TextStyle(
          color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
    ));
  }
}
