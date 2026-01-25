import 'package:flutter/material.dart';
import '../config/palette.dart';


class FontSizeEditor extends StatelessWidget {
  final double initialSize;
  final Function(double) onSizeChanged;
  final bool showLabel;

  const FontSizeEditor({
    super.key,
    required this.initialSize,
    required this.onSizeChanged,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel) ...[
          const Text("Size: ", style: TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(width: 4),
        ],
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Pallet.divider, width: 1),
            borderRadius: BorderRadius.circular(18),
            color: Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  if (initialSize > 1) {
                    onSizeChanged(initialSize - 1);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(Icons.remove, size: 14, color: Pallet.font2),
                ),
              ),
              SizedBox(
                width: 30,
                child: TextField(
                  controller: TextEditingController(text: initialSize.toString().replaceAll(RegExp(r'\.0$'), '')),
                  style: TextStyle(fontSize: 12, color: Pallet.font1),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  keyboardType: TextInputType.number,
                  onSubmitted: (val) {
                    final newSize = double.tryParse(val);
                    if (newSize != null) {
                      onSizeChanged(newSize);
                    }
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  onSizeChanged(initialSize + 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(Icons.add, size: 14, color: Pallet.font2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
