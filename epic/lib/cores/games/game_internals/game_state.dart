import 'package:flutter/foundation.dart';

class GameState {
  final VoidCallback onCompleteion;
  GameState({required this.onCompleteion}) {
    print('Game State Created');
  }

  void _complete() {
    onCompleteion();
  }
}
