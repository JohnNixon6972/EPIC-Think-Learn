import 'package:epic/features/account/pages/levelProgress.dart';
import 'package:epic/features/account/pages/profile_settings.dart';
import 'package:epic/features/auth/repository/user_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabPages extends ConsumerWidget {
  const TabPages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDataService = ref.read(userDataServiceProvider);
    return FutureBuilder<Map<String, int>>(
      future: userDataService.fetchStrategyLevels(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        final strategyLevels = snapshot.data!;

        return Expanded(
          child: TabBarView(children: [
            Center(
              child: LevelProgressBody(strategyLevels: strategyLevels),
            ),
            const Center(
              child: MyProfileSettings(),
            ),
          ]),
        );
      },
    );
  }
}
