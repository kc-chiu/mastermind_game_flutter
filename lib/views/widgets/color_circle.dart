import 'package:flutter/material.dart';

// Build a circle with a give color

class ColorCircle extends StatelessWidget {
  ColorCircle(this.color);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
