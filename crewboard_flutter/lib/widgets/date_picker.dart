import 'package:flutter/material.dart';
import '../config/palette.dart';
import 'buttons.dart';
import 'glass_morph.dart';
import 'dart:math' as math;
import 'package:flutter/scheduler.dart';

class WheelDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const WheelDatePicker({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<WheelDatePicker> createState() => _WheelDatePickerState();
}

class _WheelDatePickerState extends State<WheelDatePicker> {
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _yearController;

  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;

  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  late int daysInMonth;

  @override
  void initState() {
    super.initState();

    selectedDay = widget.initialDate.day;
    selectedMonth = widget.initialDate.month;
    selectedYear = widget.initialDate.year;

    // Controllers initial items (zero-based index)
    _dayController = FixedExtentScrollController(initialItem: selectedDay - 1);
    _monthController = FixedExtentScrollController(initialItem: selectedMonth - 1);
    _yearController = FixedExtentScrollController(initialItem: selectedYear - 2000);

    // initial days count (works for December as well)
    daysInMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;
  }

  void _updateDaysFor(int month, int year) {
    final int newDaysInMonth = DateTime(year, month + 1, 0).day;
    if (newDaysInMonth != daysInMonth) {
      setState(() {
        daysInMonth = newDaysInMonth;
      });

      // if the selected day is now out of range, move it to last valid day
      if (selectedDay > newDaysInMonth) {
        selectedDay = newDaysInMonth;
        // Jump after frame so the ListWheel is attached
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (mounted && _dayController.hasClients) {
            _dayController.jumpToItem(newDaysInMonth - 1);
          }
        });
      }
    }
  }

  void _onDayChanged(int index) {
    setState(() {
      selectedDay = index + 1;
    });
  }

  void _onMonthChanged(int index) {
    final int newMonth = index + 1;
    setState(() {
      selectedMonth = newMonth;
    });
    final int currentYear = 2000 + _yearController.selectedItem;
    _updateDaysFor(newMonth, currentYear);
  }

  void _onYearChanged(int index) {
    final int newYear = 2000 + index;
    setState(() {
      selectedYear = newYear;
    });
    final int currentMonth = _monthController.selectedItem + 1;
    _updateDaysFor(currentMonth, newYear);
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: GlassMorph(
          width: 400,
          height: 350,
          borderRadius: 15,
          color: Colors.white.withOpacity(0.05),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Select Date",
                style: TextStyle(
                  color: Pallet.font1,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Day wheel built from daysInMonth (dynamic)
                        _buildWheel(
                          items: List.generate(daysInMonth, (i) => (i + 1).toString()),
                          controller: _dayController,
                          onChanged: _onDayChanged,
                          offAxisFraction: -0.5,
                        ),
                        _buildWheel(
                          items: months,
                          controller: _monthController,
                          onChanged: _onMonthChanged,
                          flex: 2,
                        ),
                        _buildWheel(
                          items: List.generate(100, (i) => (2000 + i).toString()),
                          controller: _yearController,
                          onChanged: _onYearChanged,
                          offAxisFraction: 0.5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SmallButton(
                      label: "Cancel",
                      onPress: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 15),
                    SmallButton(
                      label: "Done",
                      onPress: () {
                        // Ensure final day is inside valid range
                        final int finalDay = math.max(1, math.min(selectedDay, daysInMonth));
                        final int finalMonth = selectedMonth;
                        final int finalYear = selectedYear;

                        widget.onDateSelected(DateTime(finalYear, finalMonth, finalDay));
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWheel({
    required List<String> items,
    required FixedExtentScrollController controller,
    required ValueChanged<int> onChanged,
    int flex = 1,
    double offAxisFraction = 0.0,
  }) {
    return Expanded(
      flex: flex,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onChanged,
        perspective: 0.002,
        diameterRatio: 1.8,
        offAxisFraction: offAxisFraction,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: items.length,
          builder: (context, index) {
            if (index < 0 || index >= items.length) return null;

            final bool isSelected = controller.hasClients &&
                controller.selectedItem == index;

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (controller.hasClients) {
                  controller.animateToItem(
                    index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                  );
                }
              },
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 150),
                  style: TextStyle(
                    color: isSelected
                        ? Pallet.font1
                        : Pallet.font1.withOpacity(0.6),
                    fontSize: isSelected ? 18 : 15,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  child: Text(items[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  final String? value;
  final String label;
  final VoidCallback onTap;
  final bool showCheck;

  const DatePicker({
    super.key,
    this.value,
    required this.label,
    required this.onTap,
    this.showCheck = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                (value == null || value!.isEmpty) ? label : value!,
                style: TextStyle(
                  fontSize: 12,
                  color: Pallet.font1,
                ),
              ),
            ),
            Container(
              width: 4,
              height: 15,
              decoration: BoxDecoration(
                color: (showCheck && value != null && value!.isNotEmpty)
                    ? Colors.green
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}