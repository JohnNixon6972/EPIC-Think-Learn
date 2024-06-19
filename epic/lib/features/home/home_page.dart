import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/navigation/bottom_navigation.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/account/pages/account_page.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:epic/features/pages.dart';
import 'package:epic/features/report/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app,
              size: 25, color: AppConstants.primaryTextColor),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: AppConstants.secondaryBackgroundColor,
                title: const Text(
                  "Confirm",
                  style: TextStyle(
                    color: AppConstants.primaryTextColor,
                  ),
                ),
                content: const Text(
                  "Do you want to exit the app?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppConstants.primaryTextColor,
                  ),
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: AppConstants.primaryButtonColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "NO",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppConstants.primaryTextColor,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: AppConstants.primaryButtonColor),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "YES",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppConstants.primaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        title: const Text(
          "EPIC",
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppConstants.primaryTextColor),
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return ref.watch(currentUserprovider).when(
                  data: (currentUser) => Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AccountPage(
                                    user: currentUser,
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.grey,
                              backgroundImage: CachedNetworkImageProvider(
                                  currentUser.profilePic),
                            )),
                      ),
                  error: (error, stackTrace) =>
                      ErrorPage(message: error.toString()),
                  loading: () => const Loader());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: pages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigation(
        onPressed: (index) {
          if (index != 1) {
            currentIndex = index;
            setState(() {});
          } else {
            showModalBottomSheet(
              context: context,
              builder: (context) => const Report(),
            );
          }
        },
      ),
    );
  }
}
