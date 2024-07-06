import 'package:epic/features/auth/model/user_model.dart';
import 'package:epic/features/auth/repository/user_data_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = StreamProvider<UserModel>((ref) {
  final userDataService = ref.watch(userDataServiceProvider);
  return userDataService.fetchCurrentUserData();
});