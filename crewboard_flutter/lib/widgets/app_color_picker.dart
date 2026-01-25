import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../config/palette.dart';

class AppColorPicker extends StatelessWidget {
  final String? initialColor;
  final Function(String) onColorChanged;
  final String title;

  const AppColorPicker({
    super.key,
    this.initialColor,
    required this.onColorChanged,
    this.title = 'Pick a color',
  });

  @override
  Widget build(BuildContext context) {
    Color pickerColor = initialColor != null
        ? Color(int.parse(initialColor!.replaceFirst('#', '0xff')))
        : Pallet.font2;

    return InkWell(
      onTap: () {
        Color selectedColor = pickerColor;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: selectedColor,
                  onColorChanged: (color) {
                    selectedColor = color;
                  },
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Got it'),
                  onPressed: () {
                    String hex =
                        '#${selectedColor.value.toRadixString(16).padLeft(8, '0').substring(2)}';
                    onColorChanged(hex);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: pickerColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Pallet.divider),
        ),
      ),
    );
  }
}
