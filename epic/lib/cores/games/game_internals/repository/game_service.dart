import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epic/features/strategies/model/strategy_model.dart';

class GameService {
  late StrategyModel strategyModel;
  late String userId;

  GameService(this.userId);

  void setGame({required StrategyModel strategyModel}) {
    this.strategyModel = strategyModel;
  }

  void updateLevel(int level) {
    strategyModel.level = level;
    updateStrategyOnFirebase(strategyModel);
  }

  void updateStrategyOnFirebase(StrategyModel strategyModel) {
    this.strategyModel = strategyModel;

    // update on firebase
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('strategies')
        .doc(strategyModel.strategy.name)
        .update(strategyModel.toMap());
  }

  void updateDays(int days) {
    strategyModel.days = days;
    updateStrategyOnFirebase(strategyModel);
  }

  void uploadData() {
    // Upload data to the server
  }

  get game => strategyModel.strategy.game;
  get level => strategyModel.level;
  get days => strategyModel.days;
}
