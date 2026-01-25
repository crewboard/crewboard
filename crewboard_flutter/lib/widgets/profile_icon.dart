import 'package:flutter/material.dart';

enum ProfileIconStyle { solid, outlined }

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
    required this.name,
    required this.color,
    this.size = 35,
    this.fontSize = 14,
    this.image,
    this.style = ProfileIconStyle.solid,
    this.useOpacity = true,
    this.borderRadius,
  });
  final String name;
  final Color color;
  final double size;
  final double fontSize;
  final String? image;
  final ProfileIconStyle style;
  final bool useOpacity;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: style == ProfileIconStyle.outlined && useOpacity
            ? color.withValues(alpha: 0.2)
            : color,
        borderRadius: BorderRadius.circular(borderRadius ?? size),
        border: style == ProfileIconStyle.outlined
            ? Border.all(color: color, width: 1)
            : null,
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
                  color: style == ProfileIconStyle.outlined && useOpacity
                      ? color
                      : Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
