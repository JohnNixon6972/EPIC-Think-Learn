import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic/features/account/pages/my_profile.dart';
import 'package:epic/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final UserModel user;
  const AccountPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 30),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          CachedNetworkImageProvider(user.profilePic),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyProfile()));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              user.username,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              "@${user.username}",
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.blueGrey),
                            ),
                          ),
                          const Text("Manage You Account",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.blue))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text("Privacy Policy . Terms of Service",
                    style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
