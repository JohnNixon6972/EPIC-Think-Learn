import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/account/widgets/settings_dialog.dart';
import 'package:epic/features/account/widgets/settings_item.dart';
import 'package:epic/features/account/repository/edit_field.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyProfileSettings extends ConsumerStatefulWidget {
  const MyProfileSettings({super.key});

  @override
  ConsumerState<MyProfileSettings> createState() => _MyProfileSettingsState();
}

class _MyProfileSettingsState extends ConsumerState<MyProfileSettings> {
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserProvider).when(
        data: (currentUser) => Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SettingsItem(
                            identifier: "Username",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => SettingsDialog(
                                  identifier: "Your New Username",
                                  onSave: (username) {
                                    ref
                                        .watch(editSettingsProvider)
                                        .editusername(username);
                                  },
                                ),
                              );
                            },
                            value: currentUser.username),
                        const Divider(),
                        SettingsItem(
                            identifier: "My Code",
                            onPressed: () {
                              //copy the code
                            },
                            value: "EPIC-1234"),
                        // const Divider(),
                        // SettingsItem(
                        //     identifier: "Role",
                        //     onPressed: () {
                        //       //copy the code
                        //     },
                        //     value: "Parent/child"),
                        const Divider(),
                        Row(
                          children: [
                            const Text(
                              "Keep my profile private",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Switch(
                              value: isSwitched,
                              activeColor: AppConstants.primaryColor,
                              inactiveTrackColor: AppConstants.secondaryColor,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
                              },
                            )
                          ],
                        ),
                        // const Divider(),

                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () async {
                              await GoogleSignIn().signOut();
                              await FirebaseAuth.instance.signOut();
                            },
                            child: Container(
                              height: 45,
                              width: 150,
                              decoration: const BoxDecoration(
                                color: AppConstants.tertiaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: const Center(
                                child: Text(
                                  "Log Out",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        error: (error, stackTrace) => ErrorPage(message: error.toString()),
        loading: () => const Loader());
  }
}
