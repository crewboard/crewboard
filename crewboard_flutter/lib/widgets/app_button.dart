import 'package:flutter/material.dart';
import '../config/palette.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPress,
    this.color,
  });
  final String label;
  final VoidCallback onPress;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: color ?? Pallet.inside1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          style: TextStyle(color: Pallet.font1, fontSize: 12),
        ),
      ),
    );
  }
}
