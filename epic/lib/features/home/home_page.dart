import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/navigation/bottom_navigation.dart';
import 'package:epic/cores/navigation/provider/navigation_provider.dart';
import 'package:epic/cores/widgets/main_app_bar.dart';
import 'package:epic/cores/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {


  const HomePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appNavigationProvider = ref.watch(navigationProvider);
    return Scaffold(
      backgroundColor: AppConstants.primaryButtonColor,
      appBar: mainAppBar(context),
      body: SafeArea(
        child: pages[appNavigationProvider.currentIndex],
      ),
      bottomNavigationBar: BottomNavigation(
        onPressed: (index) {
          appNavigationProvider.setIndex(index);
        },
      ),
    );
  }
}
