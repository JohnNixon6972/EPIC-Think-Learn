import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/account/pages/my_profile.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

AppBar mainAppBar(BuildContext context) {
  return AppBar(
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
              ElevatedButton(
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
              ElevatedButton(
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
          return ref.watch(currentUserProvider).when(
              data: (currentUser) => Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                        onTap: () {
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
  );
}
