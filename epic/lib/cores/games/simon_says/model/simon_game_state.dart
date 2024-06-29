import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';

class SimonGameState {
  final List<String> shapes;
  final List<Color> colors;
  String? currentShape;
  Color? currentColor;
  String query;
  String message;
  Color backgroundColor;
  int? score;
  Duration? elapsedTime;
  bool isGameOver;
  bool isGameWon;

  SimonGameState({
    this.shapes = const [
      "Square",
      "Circle",
      "Triangle",
      "Pentagon",
      "Hexagon",
      "Star",
      "Heart",
      "Diamond",
      "Cross",
    ],
    this.colors = const [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.black,
      Colors.yellow,
      Colors.orange,
      Colors.pink,
      Colors.purple,
      Colors.brown,
    ],
    this.currentShape = "Square",
    this.currentColor = Colors.red,
    this.backgroundColor = AppConstants.inhibitionColor,
    this.query = "Color the Square red",
    this.message = "",
    this.score = 0,
    this.elapsedTime = Duration.zero,
    this.isGameOver = true,
    this.isGameWon = false,
  });

  SimonGameState copyWith({
    List<String>? shapes,
    List<Color>? colors,
    String? currentShape,
    Color? currentColor,
    String? query,
    String? message,
    Color? backgroundColor,
    int? score,
    Duration? elapsedTime,
    bool? isGameOver,
    bool? isGameWon,
  }) {
    return SimonGameState(
      shapes: shapes ?? this.shapes,
      colors: colors ?? this.colors,
      currentShape: currentShape ?? this.currentShape,
      currentColor: currentColor ?? this.currentColor,
      query: query ?? this.query,
      message: message ?? this.message,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      score: score ?? this.score,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      isGameOver: isGameOver ?? this.isGameOver,
      isGameWon: isGameWon ?? this.isGameWon,
    );
  }
}
