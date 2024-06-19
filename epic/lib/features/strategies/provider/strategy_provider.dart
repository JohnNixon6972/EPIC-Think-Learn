import 'package:epic/features/strategies/model/strategy_model.dart';
import 'package:epic/features/strategies/repository/strategy_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum StrategyNav { detail, activityOverview, activity }

final strategyStreamProvider =
    StreamProvider.family<StrategyModel, String>((ref, strategyName) {
  final strategyService = ref.read(strategyServiceProvider);
  return strategyService.streamStrategy(strategyName);
});
