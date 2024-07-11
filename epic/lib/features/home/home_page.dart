import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/navigation/bottom_navigation.dart';
import 'package:epic/cores/widgets/main_app_bar.dart';
import 'package:epic/cores/pages.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryButtonColor,
      appBar: mainAppBar(context),
      body: SafeArea(
        child: pages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigation(
        onPressed: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
