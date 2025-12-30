import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
    required this.name,
    required this.color,
    this.size = 35,
    this.fontSize = 14,
    this.image,
  });
  final String name;
  final Color color;
  final double size;
  final double fontSize;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size),
        image: image != null
            ? DecorationImage(image: NetworkImage(image!), fit: BoxFit.cover)
            : null,
      ),
      child: image == null
          ? Center(
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : "?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
