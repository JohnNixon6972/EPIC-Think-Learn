import 'package:epic/cores/games/game_internals/repository/game_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameServiceProvider = Provider<GameService>((ref) {
  return GameService();
});
