import 'package:epic/cores/games/simon_says/reposiotry/simon_game_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorPaletteDialog extends ConsumerWidget {
  final String shape;

  const ColorPaletteDialog({super.key, required this.shape});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(gameProvider.select((state) => state.colors));
    return AlertDialog(
      title: const Text('Select a Color'),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          children: colors.map((color) {
            return GestureDetector(
              onTap: () {
                ref
                    .read(gameProvider.notifier)
                    .checkUserSelection(shape, color);
                Navigator.of(context).pop();
              },
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    color: color,
                  ),
                  const SizedBox(height: 5),
                  Text(GameNotifier.currentColorToString(color)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
