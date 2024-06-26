import 'package:epic/cores/games/simon_says/repository/simon_game_notifier.dart';
import 'package:epic/cores/games/simon_says/widgets/color_palaette.dart';
import 'package:epic/cores/games/simon_says/widgets/shape_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShapesPanel extends ConsumerWidget {
  const ShapesPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shapes = ref.watch(simonGameProvider.select((state) => state.shapes));
    final level = ref.watch(simonGameProvider.notifier).count;
    ref.watch(simonGameProvider.select((state) => state.currentColor));

    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        children: shapes.sublist(0, level).map((shape) {
          return GestureDetector(
            onTap: () {
              _showColorPaletteDialog(context, shape);
            },
            child: Center(
              child: ShapeWidget(shape: shape),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showColorPaletteDialog(BuildContext context, String shape) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ColorPaletteDialog(shape: shape);
      },
    );
  }
}
