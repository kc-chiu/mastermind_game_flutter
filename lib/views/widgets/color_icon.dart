import 'package:flutter/material.dart';

// Build an icon with a default size of 42.0

class ColorIcon extends StatelessWidget {
  ColorIcon(this.icon, this.color, {this.size = 42});

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
