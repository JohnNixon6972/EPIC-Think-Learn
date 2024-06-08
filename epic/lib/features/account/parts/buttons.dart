import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 41,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(9),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Manage Profile",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.edit))),
              Expanded(
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.edit))),
            ],
          ),
        )
      ],
    );
  }
}
