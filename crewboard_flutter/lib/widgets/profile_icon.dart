import 'dart:ui';
import 'package:flutter/material.dart';

// enum ProfileIconStyle { solid, outlined }

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
    required this.name,
    required this.color,
    this.size = 35,
    this.fontSize = 14,
    this.image,
    // this.style = ProfileIconStyle.solid,
    this.borderRadius,
  });
  final String name;
  final Color color;
  final double size;
  final double fontSize;
  final String? image;
  // final ProfileIconStyle style;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget iconContent = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(borderRadius ?? size),
        border:  Border.all(color: color, width: 1),
        image: image != null
            ? DecorationImage(
                image: NetworkImage(image!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: image == null
          ? Center(
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : "?",
                style: TextStyle(
                  color: color,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? size),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: iconContent,
      ),
    );
  }
}
