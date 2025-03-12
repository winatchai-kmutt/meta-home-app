import 'dart:ui';
import 'package:flutter/material.dart';

class CircleIconBox extends StatelessWidget {
  final EdgeInsets padding;
  final ImageProvider icon;
  final double size;

  const CircleIconBox({
    super.key,
    required this.padding,
    required this.size,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: ImageIcon(icon, color: Colors.white, size: size),
        ),
      ),
    );
  }
}
