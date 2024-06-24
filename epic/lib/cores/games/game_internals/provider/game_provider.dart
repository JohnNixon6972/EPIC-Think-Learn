import 'package:epic/cores/games/game_internals/repository/game_service.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameServiceProvider = Provider<GameService>((ref) {
  final user = ref.watch(currentUserprovider).asData!.value;
  if (user.userId.isEmpty) {
    throw Exception('User not found');
  }
  return GameService( user.userId);
});
