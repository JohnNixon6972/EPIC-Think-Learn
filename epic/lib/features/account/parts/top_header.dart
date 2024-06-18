import 'package:epic/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';

class TopHeader extends StatelessWidget {
  final UserModel user;
  const TopHeader({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(user.username,
              style:
                  const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const Text(
            "Changes made on your user name and profile picture are only reflected on this app and not on any other Google Services.",
            style: TextStyle(color: Colors.blueGrey),
            textAlign: TextAlign.center,
          ),
          const Text("Get connected to your parent/child"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 30,
                width: 100,
                child: TextField(
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: 'Enter code',
                    // suffixIcon: Icon(Icons.password),
                    // contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
              TextButton.icon(onPressed: () {}, label: const Text("Connect")),
            ],
          ),
        ],
      ),
    );
  }
}
