import 'package:flutter/material.dart';
import '../config/palette.dart';

class RadialCheckBox extends StatelessWidget {
  const RadialCheckBox({
    super.key,
    required this.selected,
    required this.onSelect,
  });
  final bool selected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Pallet.font1),
        ),
        child: Center(
          child: selected
              ? Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Pallet.font1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
