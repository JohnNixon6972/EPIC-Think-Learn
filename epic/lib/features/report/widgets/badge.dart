import 'dart:math' as math;
import 'package:flutter/material.dart';

class BadgePainter extends CustomPainter {
  final double width;
  final double height;
  final Color badgeColor;
  final String strategyName;

  BadgePainter({
    required this.width,
    required this.height,
    required this.badgeColor,
    required this.strategyName,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = badgeColor;

    // Calculate the center of the circle
    Offset center = Offset(width / 2, height / 2);

    // Calculate the radius of the circle (using the smaller dimension)
    double radius = math.min(width / 2, height / 2);

    // Calculate the rectangle that bounds the circle
    Rect rect = Rect.fromCircle(center: center, radius: radius);

    // Draw the inverse arc (the bottom half of the circle)
    canvas.drawArc(
      rect,
      0, // Start angle (radians)
      math.pi, // Sweep angle (radians)
      false,
      paint,
    );

    // Number of stars
    int numberOfStars = 5;
    double starRadius = 20.0; // Adjust the size of the stars as needed
    double starPadding = 20.0; // Padding between stars and the edge of the badge

    // Calculate the total space available for stars
    double availableSpace = width - 2 * starPadding;
    double spaceBetweenStars = availableSpace / (numberOfStars - 1);

    // Calculate the position for each star along the arc
    for (int i = 0; i < numberOfStars; i++) {
      // Calculate angle for each star position
      double angle = (i + 0.5) * math.pi / (numberOfStars - 1);

      // Calculate position on the arc
      double starX = center.dx + radius * math.cos(angle);
      double starY = center.dy + radius * math.sin(angle);

      // Calculate offset for centering the icon
      Offset starOffset = Offset(starX - starRadius, starY - starRadius);

      // Draw the star icon at the calculated position
      drawStarIcon(canvas, starOffset, starRadius);
    }
  }

  void drawStarIcon(Canvas canvas, Offset center, double radius) {
    // Example: Draw a star icon (you can replace this with your own icon widget)
    Icon starIcon = Icon(
      Icons.star,
      color: Colors.yellow,
      size: radius * 2, // Size of the icon
    );


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}