import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';

class TopHeader extends StatelessWidget {
  final UserModel user;
  const TopHeader({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 38,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(user.profilePic),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 4.0),
          child: Text(user.username,
              style:
                  const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13, color: Colors.blueGrey),
              children: [
                TextSpan(text: "@${user.username}"),
                const TextSpan(text: "  Manage Your Account"),
                const TextSpan(text: "  Edit Profile")
              ],
            ),
          ),
        ),
      ],
    );
  }
}
