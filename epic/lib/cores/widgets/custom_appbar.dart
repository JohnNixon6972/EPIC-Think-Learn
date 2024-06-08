import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  const CustomAppbar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: const Icon(Icons.more_vert, color: Colors.black),
        ),
        const SizedBox(width: 6)
      ],
    );
  }
}
