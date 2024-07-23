import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epic/features/auth/model/user_model.dart';
import 'package:epic/features/strategies/model/strategy_model.dart';
import 'package:epic/features/strategies/strategies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataServiceProvider = Provider(
  (ref) => UserDataService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class UserDataService {
  FirebaseAuth auth;
  FirebaseFirestore firestore;

  UserDataService({required this.auth, required this.firestore});

  addUserDataToFirestore(
      {required String username,
      required String email,
      required List<String> strategies,
      required String lastSeenStrategy,
      required String profilePic}) async {
    UserModel user = UserModel(
      username: username,
      email: email,
      profilePic: profilePic,
      userId: auth.currentUser!.uid,
      type: 'User',
      lastSeenStrategy: lastSeenStrategy,
      strategies: strategies,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toMap());

    for (Strategies strategy in Strategies.values) {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('strategies')
          .doc(strategy.name)
          .set(StrategyModel(
            level: 1,
            days: 0,
            strategy: strategy,
            averageAccuracy: 0,
            averageTime: 0,
            lastPlayed: DateTime.now(),
            timesPlayed: 0,
            streak: 0,
            maxStreak: 0,
          ).toMap());
    }
  }

  Stream<UserModel> fetchCurrentUserData() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) =>
            UserModel.fromMap(snapshot.data() as Map<String, dynamic>));
  }

  Future<Map<String, int>> fetchStrategyLevels() async {
    final strategies = [
      'Attention',
      'Inhibition',
      'Memory',
      'Planning',
      'Self Regulation'
    ];

    Map<String, int> strategyLevels = {};

    for (var strategy in strategies) {
      final docRef = firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('strategies')
          .doc(strategy);

      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        strategyLevels[strategy] = data['levels'];
      } else {
        strategyLevels[strategy] = 0; 
      }
    }

    return strategyLevels;
  }

  void updateStreaks() async {
    final strategies = [
      'Attention',
      'Inhibition',
      'Memory',
      'Planning',
      'Self Regulation'
    ];
    for (var strategy in strategies) {
      final docRef = firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('strategies')
          .doc(strategy);
      final lastSeenVal = await docRef
          .get()
          .then((value) => value.data()!['lastPlayed'].millisecondsSinceEpoch);
      DateTime lastSeen = DateTime.fromMillisecondsSinceEpoch(lastSeenVal);

      // if the last played date is today, do nothing else if the last played date is not today and the last played date is yesterday, increment the streak
      if (lastSeen.day == DateTime.now().day) {
        docRef.update({'streak': FieldValue.increment(1)});
      } else if (lastSeen.day == DateTime.now().day - 1) {
        // increment the streak
        docRef.update({'streak': FieldValue.increment(1)});
      } else {
        docRef.update({'streak': 0});
      }

      // update the max streak
      final maxStreakVal =
          await docRef.get().then((value) => value.data()!['maxStreak']);
      int maxStreak = maxStreakVal;
      final streakVal =
          await docRef.get().then((value) => value.data()!['streak']);
      int streak = streakVal;
      if (streak > maxStreak) {
        docRef.update({'maxStreak': streak});
      }
    }
  }

  void updateLastSeenStrategy(String name) {
    firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'lastSeenStrategy': name});
  }
}
