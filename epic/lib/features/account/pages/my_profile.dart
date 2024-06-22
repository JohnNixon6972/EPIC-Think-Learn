import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/account/parts/tab_bar.dart';
import 'package:epic/features/account/parts/tab_bar_view.dart';
import 'package:epic/features/account/parts/top_header.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyProfile extends ConsumerWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserprovider).when(
        data: (currentUser) => DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: AppConstants.primaryBackgroundColor,
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    TopHeader(user: currentUser),
                    // const Buttons(),
                    const PageTabBar(),
                    const TabPages()
                  ],
                ),
              )),
            )),
        error: (error, stackTrace) => ErrorPage(
              message: error.toString(),
            ),
        loading: () => const Loader());
  }
}
