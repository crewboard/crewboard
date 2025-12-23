import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMorph extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double? width;
  final double? height;
  final double sigmaX;
  final double sigmaY;
  final Color color;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const GlassMorph({
    super.key,
    required this.child,
    this.borderRadius = 18.0,
    this.width,
    this.height,
    this.sigmaX = 20.0,
    this.sigmaY = 20.0,
    this.color = const Color(0x19000000),
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: margin,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
            child: Container(padding: padding, color: color, child: child),
          ),
        ),
      ),
    );
  }
}
