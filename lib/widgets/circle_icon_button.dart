import 'dart:ui';

import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapCancel;
  final EdgeInsets padding;
  final ImageProvider icon;
  final double size;
  final ImageFilter? filter;
  final Color? color;
  final Color? iconColor;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.padding,
    required this.size,
    this.filter,
    this.color,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.white.withValues(alpha: 0.2),
        child: InkWell(
          splashColor: Colors.black54,
          onTap: onTap,
          onTapDown: (_) {
            onTapDown?.call();
          },
          onTapUp: (_) {
            onTapUp?.call();
          },
          onTapCancel: () {
            onTapCancel?.call();
          },
          child: ClipOval(
            child: BackdropFilter(
              filter: filter ?? ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
              child: Container(
                padding: padding,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                child: ImageIcon(
                  icon,
                  color: iconColor ?? Colors.white,
                  size: size,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
