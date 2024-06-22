import 'package:epic/cores/games/simon_says/controllers/color_tile_controller.dart';
import 'package:flutter/material.dart';

class ColorTile extends StatefulWidget {
  final Color color;
  final ColorTileController controller;
  final Function onTap;

  const ColorTile(
      {super.key,
      required this.color,
      required this.controller,
      required this.onTap});

  @override
  State<ColorTile> createState() => _ColorTileState();
}

class _ColorTileState extends State<ColorTile> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateOpacity);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateOpacity);
    super.dispose();
  }

  void _updateOpacity() {
    setState(() {});
  }

  void _handleTap() {
    widget.controller.animate();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: widget.color.withOpacity(widget.controller.opacity),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        duration: const Duration(milliseconds: 500),
        height: 100,
        width: 100,
      ),
    );
  }
}
