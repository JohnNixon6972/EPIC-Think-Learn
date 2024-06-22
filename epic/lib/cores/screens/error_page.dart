// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  const ErrorPage({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    print('Error Page: $message');
    return const Center();
  }
}
