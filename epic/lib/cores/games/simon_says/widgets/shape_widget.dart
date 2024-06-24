import 'package:epic/cores/games/simon_says/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:morphable_shape/morphable_shape.dart';

class ShapeWidget extends StatelessWidget {
  final String shape;

  const ShapeWidget({super.key, required this.shape});
  static const double size = 80;

  @override
  Widget build(BuildContext context) {
    switch (shape) {
      case "Square":
        return Container(width: size, height: size, color: Colors.white);
      case "Circle":
        return Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        );
      case "Triangle":
        return CustomPaint(
            size: const Size(size, size), painter: TrianglePainter());
      case "Pentagon":
        return const SizedBox(
          height: size,
          width: size,
          child: Material(
            color: Colors.white,
            shape: PolygonShapeBorder(sides: 5),
            child: Center(),
          ),
        );
      case "Hexagon":
        return const SizedBox(
          height: size,
          width: size,
          child: Material(
            color: Colors.white,
            shape: PolygonShapeBorder(sides: 6),
            child: Center(),
          ),
        );
      case "Star":
        return const SizedBox(
            height: size,
            width: size,
            child: Material(
              color: Colors.white,
              shape: StarShapeBorder(corners: 5),
            ));
      case "Heart":
        return const Icon(Icons.favorite, size: size, color: Colors.white);
      case "Diamond":
        return CustomPaint(
            size: const Size(size, size), painter: DiamondPainter());
      case "Cross":
        return CustomPaint(
            size: const Size(size, size), painter: CrossPainter());
      default:
        return Container(); // Or throw an error or handle the case where shape is unknown
    }
  }
}
