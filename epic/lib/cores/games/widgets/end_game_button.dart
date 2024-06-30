
import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';

class EndGameButton extends StatelessWidget {
  final void Function() endGame;
  const EndGameButton({
    super.key,
    required this.endGame,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppConstants.primaryBackgroundColor,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: AppConstants.primaryButtonColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: endGame,
      child: const Text(
        'End Game',
        style: TextStyle(
            fontSize: 18,
            color: AppConstants.primaryButtonColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
