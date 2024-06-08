import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/account/widgets/settings_dialog.dart';
import 'package:epic/features/account/widgets/settings_item.dart';
import 'package:epic/features/account/repository/edit_field.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                              height: 170,
                              width: double.infinity,
                              child: Image.network(
                                currentUser.profilePic,
                                fit: BoxFit.cover,
                              )),
                          Positioned(
                            left: 180,
                            top: 60,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey,
                              backgroundImage: CachedNetworkImageProvider(
                                  currentUser.profilePic),
                            ),
                          ),
                          Positioned(
                            left: 180,
                            top: 120,
                            child: Text(
                              currentUser.username,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 14),
                          SettingsItem(
                            identifier: "Name",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => SettingsDialog(
                                  identifier: "Your New Display Name",
                                  onSave: (name) {
                                    ref
                                        .watch(editSettingsProvider)
                                        .editDisplayName(name);
                                  },
                                ),
                              );
                            },
                            value: currentUser.username,
                          ),
                          const SizedBox(height: 14),
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
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 8),
                            child: Row(
                              children: [
                                const Text(
                                  "Kepp my profile private",
                                ),
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
                          ),
                          const Text(
                            "Changes made on your name and profile pictures are visible only on this app and not other Google Services.",
                            style: TextStyle(color: Colors.blueGrey),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
        error: (error, stackTrace) => const ErrorPage(),
        loading: () => const Loader());
  }
}
