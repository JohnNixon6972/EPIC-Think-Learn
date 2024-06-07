import 'package:epic/features/auth/model/user_model.dart';
import 'package:epic/features/auth/repository/user_data_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserprovider = FutureProvider<UserModel>((ref) async {
  final UserModel user =
      await ref.watch(userDataServiceProvider).fetchCurrentUserData();

  return user;
});

final anyUserDataProvider =
    FutureProvider.family<UserModel, String>((ref, userId) async {
  final UserModel user =
      await ref.watch(userDataServiceProvider).fetchAnyUserData(userId);

  return user;
});
