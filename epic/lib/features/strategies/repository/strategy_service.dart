import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epic/features/strategies/model/strategy_model.dart';
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

  Stream<StrategyModel> streamStrategy(String strategy) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('strategies')
        .doc(strategy)
        .snapshots()
        .map((snapshot) =>
            StrategyModel.fromMap(snapshot.data() as Map<String, dynamic>));
  } 
}
