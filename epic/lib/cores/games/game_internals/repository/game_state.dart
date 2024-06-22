
import 'package:epic/features/strategies/model/strategy_model.dart';

class GameService {
  late StrategyModel strategyModel;

  void setGame({required StrategyModel strategyModel}) {
    this.strategyModel = strategyModel;
  }

  void updateLevel(int level) {
    strategyModel.level = level;
  }

  void updateDays(int days) {
    strategyModel.days = days;
  }

  void uploadData() {
    // Upload data to the server
  }

  get game => strategyModel.strategy.game;
  get level => strategyModel.level;
  get days => strategyModel.days;
  
}
