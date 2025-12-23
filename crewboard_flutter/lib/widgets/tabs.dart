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
    return Row(
      children: [
        for (var tab in tabs)
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: InkWell(
              onTap: () => onTabChanged(tab.value),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: tab.isSelected ? Pallet.inside1 : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: tab.isSelected ? Pallet.font3 : Colors.transparent,
                  ),
                ),
                child: Text(
                  tab.label,
                  style: TextStyle(
                    color: tab.isSelected ? Pallet.font1 : Pallet.font3,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
