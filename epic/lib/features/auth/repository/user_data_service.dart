import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epic/features/auth/model/user_model.dart';
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
      required String profilePic}) async {
    UserModel user = UserModel(
      username: username,
      email: email,
      profilePic: profilePic,
      userId: auth.currentUser!.uid,
      type: 'user',
      strategies: strategies,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toMap());
  }

  Future<UserModel> fetchCurrentUserData() async {
    DocumentSnapshot currentUserMap =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();

    UserModel user =
        UserModel.fromMap(currentUserMap.data() as Map<String, dynamic>);
    return user;
  }

  Future<UserModel> fetchAnyUserData(String userId) async {
    DocumentSnapshot currentUserMap =
        await firestore.collection('users').doc(userId).get();

    UserModel user =
        UserModel.fromMap(currentUserMap.data() as Map<String, dynamic>);
    return user;
  }
}
