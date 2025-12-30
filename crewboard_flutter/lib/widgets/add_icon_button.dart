import 'package:flutter/material.dart';
import '../config/palette.dart';

class AddIconButton extends StatelessWidget {
  const AddIconButton({super.key, required this.onPress});
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
