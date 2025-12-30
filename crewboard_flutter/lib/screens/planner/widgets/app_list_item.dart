import 'package:flutter/material.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../../config/palette.dart';

class AppListItem extends StatelessWidget {
  const AppListItem({
    super.key,
    required this.app,
    required this.isSelected,
    required this.onTap,
  });
  final PlannerApp app;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Pallet.inside2 : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Pallet.inside3 : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          app.appName,
          style: TextStyle(
            color: Pallet.font2,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
