import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/tea_towel/model/tea_game_state.dart';
import 'package:epic/cores/games/tea_towel/repository/tea_game_notifier.dart';
import 'package:flutter/material.dart';

class ItemSelection extends StatelessWidget {
  const ItemSelection({
    super.key,
    required this.gameState,
    required this.gameNotifier,
  });

  final TeaGameState gameState;
  final TeaGameNotifier gameNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: gameState.objects.map((item) {
              String itemName = item.name;
              bool isSelected = gameState.userSelectedItems.contains(itemName);

              return TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    isSelected
                        ? gameState.backgroundColor.withOpacity(1)
                        : AppConstants.primaryBackgroundColor,
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: gameState.backgroundColor.withOpacity(1),
                          width: 1,
                        )),
                  ),
                ),
                onPressed: () {
                  gameNotifier.selectItem(itemName);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        itemName,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? AppConstants.primaryTextColor
                                : gameState.backgroundColor.withOpacity(1)),
                      ),
                    ),
                    gameNotifier.isCorrectItem(itemName)
                        ? const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 5),
                              Icon(Icons.check_circle_outline_rounded,
                                  color: Colors.green),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          style: TextButton.styleFrom(
            elevation: 10,
            shadowColor: Colors.black,
            backgroundColor: AppConstants.primaryButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            gameNotifier.checkItems();
          },
          child: const Text(
            'Check Answer',
            style: TextStyle(
              color: AppConstants.primaryTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
