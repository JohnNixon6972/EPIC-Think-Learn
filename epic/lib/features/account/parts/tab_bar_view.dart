import 'package:epic/features/account/pages/profile_settings.dart';
import 'package:flutter/material.dart';

class TabPages extends StatelessWidget {
  const TabPages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: TabBarView(children: [
      Center(child: Text("Progress")),
      Center(child: Text("Profile")),
      Center(child: MyProfileSettings()),
    ]));
  }
}
