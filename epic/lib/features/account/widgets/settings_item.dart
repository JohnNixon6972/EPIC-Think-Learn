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
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(value)
          ],
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.edit),
        )
      ],
    );
  }
}
