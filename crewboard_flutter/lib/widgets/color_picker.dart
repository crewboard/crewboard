import 'package:flutter/material.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:crewboard_flutter/main.dart';
import 'package:collection/collection.dart';
import '../config/palette.dart';
import 'glass_morph.dart';
import 'buttons.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.selectedColorId,
    required this.onColorSelected,
  });
  final UuidValue? selectedColorId;
  final Function(SystemColor) onColorSelected;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  final GlobalKey _pickerKey = GlobalKey();
  final TextEditingController _hexController = TextEditingController();
  final ValueNotifier<bool> _isAdding = ValueNotifier<bool>(false);
  OverlayEntry? _dropdown;
  bool _isOpen = false;

  List<SystemColor> _defaultColors = [];
  List<SystemColor> _customColors = [];
  SystemColor? _selectedSystemColor;

  @override
  void initState() {
    super.initState();
    _loadColors();
  }

  Future<void> _loadColors() async {
    try {
      final allColors = await client.admin.getColors();
      setState(() {
        _defaultColors = allColors.where((c) => c.isDefault).toList();
        _customColors = allColors.where((c) => !c.isDefault).toList();

        if (widget.selectedColorId != null) {
          _selectedSystemColor = allColors.firstWhereOrNull(
            (c) => c.id == widget.selectedColorId,
          );
        } else if (_defaultColors.isNotEmpty) {
          _selectedSystemColor = _defaultColors.first;
          widget.onColorSelected(_selectedSystemColor!);
        }
      });
    } catch (e) {
      debugPrint("Error fetching colors: $e");
    }
  }

  void _hideDropdown() {
    _dropdown?.remove();
    _dropdown = null;
    setState(() {
      _isOpen = false;
    });
  }

  void _showDropdown() {
    final renderBox =
        _pickerKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    _dropdown = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: _hideDropdown,
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              Positioned(
                top: offset.dy,
                left: offset.dx - 100, // Shifted to center roughly
                width: 200,
                child: Material(
                  color: Colors.transparent,
                  elevation: 10,
                  child: GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.opaque,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _isAdding,
                      builder: (context, isAdding, _) {
                        return GlassMorph(
                          padding: const EdgeInsets.all(10),
                          borderRadius: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (isAdding)
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Pallet.inside3,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller: _hexController,
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                      hintText: "hex...",
                                                      hintStyle: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.grey,
                                                      ),
                                                      isDense: true,
                                                      border: InputBorder.none,
                                                    ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _isAdding.value = false;
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  const SizedBox(width: 5),
                                  AddButton(
                                    onPress: () async {
                                      if (_isAdding.value) {
                                        String hex = _hexController.text
                                            .replaceAll("#", "");
                                        if (hex.length == 6) {
                                          hex = "0xFF$hex";
                                        }
                                        try {
                                          await client.admin.addColor(hex);
                                          _hexController.clear();
                                          _isAdding.value = false;
                                          await _loadColors();
                                        } catch (e) {
                                          debugPrint("Error adding color: $e");
                                        }
                                      } else {
                                        _isAdding.value = true;
                                      }
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Colors",
                                style: TextStyle(
                                  color: Pallet.font2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (var color in _defaultColors)
                                    _buildColorCircle(color),
                                ],
                              ),
                              if (_customColors.isNotEmpty) ...[
                                const SizedBox(height: 15),
                                Text(
                                  "Custom",
                                  style: TextStyle(
                                    color: Pallet.font2,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    for (var color in _customColors)
                                      _buildColorCircle(color),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(_dropdown!);
    setState(() {
      _isOpen = true;
    });
  }

  Widget _buildColorCircle(SystemColor color) {
    final hex = color.color.replaceAll("#", "0xFF");
    final flutterColor = Color(int.parse(hex));
    final isSelected = widget.selectedColorId == color.id;

    return InkWell(
      onTap: () {
        widget.onColorSelected(color);
        setState(() {
          _selectedSystemColor = color;
        });
        _hideDropdown();
      },
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: flutterColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 4,
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dropdown?.remove();
    _hexController.dispose();
    _isAdding.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hex =
        _selectedSystemColor?.color.replaceAll("#", "0xFF") ?? "0xFF2196F3";
    final flutterColor = Color(int.parse(hex));

    return InkWell(
      key: _pickerKey,
      onTap: () {
        if (_isOpen) {
          _hideDropdown();
        } else {
          _showDropdown();
        }
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: flutterColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
      ),
    );
  }
}
