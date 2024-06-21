import 'package:flutter/material.dart';

class ColorTileController extends ChangeNotifier {
  double _opacity = 1.0;

  double get opacity => _opacity;

  set opacity(double value) {
    if (_opacity != value) {
      _opacity = value;
      notifyListeners();
    }
  }

  void animate() {
    opacity = 0.5;
    Future.delayed(const Duration(milliseconds: 500), () {
      opacity = 1.0;
    });
  }
}
