import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/globals.dart';

class TabItem {
  final String label;
  final String value;
  final bool isSelected;

  TabItem({
    required this.label,
    required this.value,
    required this.isSelected,
  });
}

class Tabs extends StatelessWidget {
  final List<TabItem> tabs;
  final Function(String) onTabChanged;

  const Tabs({
    super.key,
    required this.tabs,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: tabs.map((tab) {
        return Row(
          children: [
            InkWell(
              onTap: () => onTabChanged(tab.value),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: tab.isSelected ? Pallet.inside1 : Pallet.inside1,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: tab.isSelected ? Pallet.font2 : Pallet.font3,
                  ),
                ),
                child: Text(
                  tab.label,
                  style: TextStyle(
                    color: tab.isSelected ? Pallet.font2 : Pallet.font3,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            if (tabs.indexOf(tab) < tabs.length - 1) SizedBox(width: 8),
          ],
        );
      }).toList(),
    );
  }
}