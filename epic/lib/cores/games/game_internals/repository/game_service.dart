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

  void updateDays() {
    strategyModel.days++;
    updateStrategyOnFirebase(strategyModel);
  }

  bool updateAverageTime(int currentTime) {
    int prev = strategyModel.averageTime;

    if (strategyModel.averageTime == 0) {
      strategyModel.averageTime = currentTime;
    } else {
      strategyModel.averageTime *= strategyModel.timesPlayed;
      strategyModel.averageTime += currentTime;
      strategyModel.timesPlayed++;
      strategyModel.averageTime ~/= strategyModel.timesPlayed;
    }

    updateStrategyOnFirebase(strategyModel);
    return prev < strategyModel.averageTime;
  }

  bool updateAverageAccuracy(int currentAccuracy) {
    int prev = strategyModel.averageAccuracy;
    if (strategyModel.averageAccuracy == 0) {
      strategyModel.averageAccuracy = currentAccuracy;
    } else {
      strategyModel.averageAccuracy *= strategyModel.timesPlayed;
      strategyModel.averageAccuracy += currentAccuracy;
      strategyModel.timesPlayed++;
      strategyModel.averageAccuracy ~/= strategyModel.timesPlayed;
    }
    updateStrategyOnFirebase(strategyModel);

    return prev < strategyModel.averageAccuracy;
  }

  void updateLastPlayed() {
    strategyModel.lastPlayed = DateTime.now();
    updateStrategyOnFirebase(strategyModel);
  }



  get game => strategyModel.strategy.game;
  get level => strategyModel.level;
  get days => strategyModel.days;
  get averageTime => strategyModel.averageTime;
  get averageAccuracy => strategyModel.averageAccuracy;
  get lastPlayed => strategyModel.lastPlayed;
}
