import 'package:flutter/material.dart';
import '../config/palette.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({super.key, required this.label, required this.onPress});
  final String label;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
        minimumSize: const Size(30, 30),
      ),
      onPressed: onPress,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          border: Border.all(color: Pallet.font3),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Pallet.font3),
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.add,
                color: Pallet.font3,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
