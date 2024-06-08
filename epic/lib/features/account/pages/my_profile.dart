import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyProfile extends ConsumerWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserprovider).when(
        data: (currentUser) => const DefaultTabController(
            length: 5,
            child: Scaffold(
              body: SafeArea(
                  child: Column(
                children: [
                  // TODO : TopHeader
                  Text("More abput this profile")
                  // TODO : Buttons

                  // TODO : TabBar
                  // TODO : TabPages
                ],
              )),
            )),
        error: (error, StackTrace) => const ErrorPage(),
        loading: () => const Loader());
  }
}
