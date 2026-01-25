import 'dart:io';
import 'package:flutter/material.dart';

class EmojiText extends StatelessWidget {
  final double size;
  final String emoji;

  const EmojiText({super.key, required this.size, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Text(
      emoji,
      style: TextStyle(fontSize: Platform.isWindows ? size - 5 : size),
    );
  }
}
