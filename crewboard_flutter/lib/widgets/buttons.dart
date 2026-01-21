import 'package:flutter/material.dart';
import '../config/palette.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: color ?? Pallet.inside1,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          label,
          style: TextStyle(color: Pallet.font1, fontSize: 12),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({super.key, required this.label, required this.onPress});
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

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onPress});
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(Icons.add, color: Pallet.font1, size: 18),
      ),
    );
  }
}

class ChipButton extends StatelessWidget {
  const ChipButton({super.key, required this.name, required this.onPress});
  final String name;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Pallet.font3, width: 0.5),
        ),
        child: Text(
          name,
          style: TextStyle(color: Pallet.font2, fontSize: 11),
        ),
      ),
    );
  }
}
