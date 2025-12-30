import 'package:flutter/material.dart';
import '../config/palette.dart';

class TabItem {
  final String label;
  final dynamic value;
  final bool isSelected;

  TabItem({
    required this.label,
    required this.value,
    this.isSelected = false,
  });
}

class Tabs extends StatelessWidget {
  const Tabs({
    super.key,
    required this.tabs,
    required this.onTabChanged,
  });
  final List<TabItem> tabs;
  final Function(dynamic) onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallet.inside1,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var tab in tabs)
            InkWell(
              onTap: () => onTabChanged(tab.value),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: tab.isSelected ? Pallet.inside2 : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tab.label,
                  style: TextStyle(
                    color: tab.isSelected ? Pallet.font1 : Pallet.font3,
                    fontSize: 12,
                    fontWeight: tab.isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
