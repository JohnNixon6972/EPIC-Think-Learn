import 'package:cached_network_image/cached_network_image.dart';
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
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserprovider).when(
        data: (currentUser) => Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 180,
                            width: double.infinity,
                            child: Image.network(
                              "https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg?size=626&ext=jpg&ga=GA1.1.1141335507.1717891200&semt=sph",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width / 2 - 50,
                            top: 180 / 2 - 50,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey,
                              backgroundImage: CachedNetworkImageProvider(
                                  currentUser.profilePic),
                            ),
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width / 2 - 25,
                            top: 145,
                            child: Text(
                              currentUser.username,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            SettingsItem(
                                identifier: "Handle",
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
                            const SizedBox(height: 14),
                            SettingsItem(
                              identifier: "Description",
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => SettingsDialog(
                                    identifier: "Your New Description",
                                    onSave: (description) {
                                      ref
                                          .watch(editSettingsProvider)
                                          .editDescription(description);
                                    },
                                  ),
                                );
                              },
                              value: currentUser.username,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Kepp my profile private",
                                ),
                                const SizedBox(width: 10),
                                Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () async {
                                  await GoogleSignIn().signOut();
                                  await FirebaseAuth.instance.signOut();
                                },
                                child: Container(
                                  height: 47,
                                  width: 170,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Log Out",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 90,
                            ),
                            const Text(
                              "Changes made on your name and profile pictures are visible only on this app and not other Google Services.",
                              style: TextStyle(color: Colors.blueGrey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        error: (error, stackTrace) => const ErrorPage(),
        loading: () => const Loader());
  }
}
