import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epic/features/strategies/model/strategy_model.dart';
import 'package:epic/features/strategies/strategies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final strategyServiceProvider = Provider(
  (ref) => StrategyService(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance),
);

class StrategyService {
  FirebaseFirestore firestore;
  FirebaseAuth auth;

  StrategyService({required this.firestore, required this.auth});

  Future<Strategies> fetchStrategy(String strategy) async {
    DocumentSnapshot strategyMap = await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('strategies')
        .doc(strategy)
        .get();

    return StrategyModel.fromMap(strategyMap.data() as Map<String, dynamic>)
        .strategy;
  }
}
