


import 'package:flutter/material.dart';
import 'package:frontend/globals.dart';

class SideBarButton extends StatelessWidget {
  const SideBarButton({super.key, required this.label, required this.onPress, required this.isActive});
  final String label;
  final Function onPress;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        decoration: BoxDecoration(color: isActive ? Pallet.inside1 : Colors.transparent, borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Text(label),
          ],
        ),
      ),
    );
  }
}
