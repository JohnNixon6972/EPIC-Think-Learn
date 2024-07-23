import 'package:epic/features/account/pages/levelProgress.dart';
import 'package:epic/features/account/pages/profile_settings.dart';
import 'package:flutter/material.dart';

class TabPages extends StatelessWidget {
  
  const TabPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TabBarView(children: [
      Center(
        child: LevelProgressBody(),
      ),
      Center(
        child: MyProfileSettings(),
      ),
    ]));
  }
}
