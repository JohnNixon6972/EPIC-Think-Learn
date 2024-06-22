import 'package:epic/cores/app_constants.dart';
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
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: Text(
                "Get connected to your parent/child",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.secondaryBackgroundColor,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(fontSize: 17),
                    hintText: 'Enter code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),

                    // suffixIcon: Icon(Icons.password),
                    // contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppConstants.primaryButtonColor,
                ),
                child: TextButton.icon(
                    icon: const Icon(
                      Icons.connect_without_contact,
                      color: AppConstants.primaryTextColor,
                    ),
                    onPressed: () {},
                    label: const Text(
                      "Connect",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.primaryTextColor,
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
