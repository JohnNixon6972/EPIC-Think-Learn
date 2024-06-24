import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ),
  );
}

String getGreetings() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning ⛅️';
  }
  if (hour < 17) {
    return 'Good Afternoon 🌤';
  }
  return 'Good Evening 🌙';
}

String formatDuration(Duration duration) {
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds % 60;
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}