import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String identifier;
  final VoidCallback onPressed;
  final String value;
  const SettingsItem(
      {required this.identifier,
      required this.onPressed,
      required this.value,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              identifier,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: AppConstants.tertiaryColor,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            this.identifier == "Code" ? Icons.copy : Icons.edit,
            color: AppConstants.primaryColor,
          ),
        )
      ],
    );
  }
}
