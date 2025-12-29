import 'package:flutter/material.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:crewboard_flutter/main.dart';
import 'package:collection/collection.dart';
import '../config/palette.dart';
import 'glass_morph.dart';

class SmallTextBox extends StatefulWidget {
  const SmallTextBox({
    super.key,
    this.controller,
    this.maxLines,
    this.onType,
    this.onEnter,
    this.hintText,
    this.focus,
    this.radius,
    this.errorText,
    this.type,
    this.isPassword = false,
  });
  final TextEditingController? controller;
  final int? maxLines;
  final Function(String)? onType;
  final Function(String)? onEnter;
  final String? hintText;
  final FocusNode? focus;
  final double? radius;
  final bool isPassword;
  final String? errorText;
  final String? type;

  @override
  State<SmallTextBox> createState() => _SmallTextBoxState();
}

class _SmallTextBoxState extends State<SmallTextBox> {
  bool hasError = false;
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focus ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    if (widget.errorText != null) {
      hasError = true;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focus == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallet.inside1,
        borderRadius: BorderRadius.circular(widget.radius ?? 5),
        border: Border.all(
          color: hasError
              ? Colors.red
              : _hasFocus
              ? Pallet.font1
              : Colors.transparent,
        ),
      ),
      child: TextField(
        controller: widget.controller,
        maxLines: widget.isPassword ? 1 : (widget.maxLines ?? 1),
        obscureText: widget.isPassword,
        focusNode: _focusNode,
        style: TextStyle(color: Pallet.font1, fontSize: 13),
        onChanged: widget.onType,
        onSubmitted: widget.onEnter,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Pallet.font3, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key,
    required this.label,
    required this.onPress,
    this.color,
  });
  final String label;
  final VoidCallback onPress;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: color ?? Pallet.inside1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          style: TextStyle(color: Pallet.font1, fontSize: 12),
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onPress});
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(Icons.add, color: Pallet.font1, size: 18),
      ),
    );
  }
}

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
    required this.name,
    required this.color,
    this.size = 35,
    this.fontSize = 14,
    this.image,
  });
  final String name;
  final Color color;
  final double size;
  final double fontSize;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size),
        image: image != null
            ? DecorationImage(image: NetworkImage(image!), fit: BoxFit.cover)
            : null,
      ),
      child: image == null
          ? Center(
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : "?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}

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
        height: 60,
        width: 60,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Pallet.inside1 : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: ProfileIcon(
            name: app.appName,
            color: Colors.blue, // TODO: Map colorId to actual color
            size: 40,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class AddController extends StatefulWidget {
  const AddController({
    super.key,
    required this.onSave,
    this.showColor = false,
  });
  final Function(String, UuidValue?) onSave;
  final bool showColor;

  @override
  State<AddController> createState() => _AddControllerState();
}

class _AddControllerState extends State<AddController> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey _actionKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  UuidValue? _selectedColorId;
  bool _isOpen = false;

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
    });
  }

  void _showOverlay() {
    final renderBox =
        _actionKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: _hideOverlay,
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: offset.dy + size.height + 5,
                child: GestureDetector(
                  onTap: () {}, // Prevent tap from closing overlay
                  child: Material(
                    color: Colors.transparent,
                    child: GlassMorph(
                      width: 220,
                      borderRadius: 10,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(color: Pallet.font1, fontSize: 12),
                          ),
                          const SizedBox(height: 10),
                          SmallTextBox(
                            controller: _controller,
                            hintText: "Enter name...",
                          ),
                          if (widget.showColor) ...[
                            const SizedBox(height: 10),
                            ColorPicker(
                              selectedColorId: _selectedColorId,
                              onColorSelected: (systemColor) {
                                setState(() {
                                  _selectedColorId = systemColor.id;
                                });
                                _overlayEntry?.markNeedsBuild();
                              },
                            ),
                          ],
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SmallButton(
                                label: "Cancel",
                                onPress: _hideOverlay,
                              ),
                              const SizedBox(width: 10),
                              SmallButton(
                                label: "Save",
                                color: Colors.blue.withValues(alpha: 0.2),
                                onPress: () {
                                  widget.onSave(
                                    _controller.text,
                                    _selectedColorId,
                                  );
                                  _controller.clear();
                                  _hideOverlay();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddButton(
      key: _actionKey,
      onPress: () {
        if (_isOpen) {
          _hideOverlay();
        } else {
          _showOverlay();
        }
      },
    );
  }
}

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

class CustomBadge extends StatelessWidget {
  const CustomBadge({super.key, required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ChipButton extends StatelessWidget {
  const ChipButton({super.key, required this.name, required this.onPress});
  final String name;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Pallet.font3, width: 0.5),
        ),
        child: Text(
          name,
          style: TextStyle(color: Pallet.font2, fontSize: 11),
        ),
      ),
    );
  }
}

class MultiSelect extends StatefulWidget {
  const MultiSelect({
    super.key,
    required this.items,
    required this.selected,
    this.width = 150,
  });
  final List<dynamic> items;
  final List<dynamic> selected;
  final double width;

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  double height = 0, width = 0, initX = 0, initY = 0;
  GlobalKey actionKey = GlobalKey();
  OverlayEntry? dropdown;
  bool isOpen = false;

  void findDropDownData() {
    RenderBox renderBox =
        actionKey.currentContext!.findRenderObject() as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    initX = offset.dx;
    initY = offset.dy;
  }

  OverlayEntry _createDropDown() {
    return OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            close();
          },
          child: Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  left: initX,
                  top: initY + height + 2,
                  child: GestureDetector(
                    onTap: () {},
                    child: Material(
                      shadowColor: Colors.transparent,
                      elevation: 1,
                      color: Colors.transparent,
                      child: GlassMorph(
                        width: widget.width,
                        borderRadius: 5,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 250),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              for (var item in widget.items)
                                InkWell(
                                  onTap: () {
                                    if (widget.selected.contains(item)) {
                                      widget.selected.remove(item);
                                    } else {
                                      widget.selected.add(item);
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: widget.selected.contains(item)
                                          ? Pallet.font1.withValues(alpha: 0.1)
                                          : Colors.transparent,
                                    ),
                                    child: Row(
                                      children: [
                                        ProfileIcon(
                                          name: _getItemName(item),
                                          color: _getItemColor(item),
                                          size: 25,
                                          fontSize: 10,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            _getItemName(item),
                                            style: TextStyle(
                                              color: Pallet.font1,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        if (widget.selected.contains(item))
                                          const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                            size: 16,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getItemName(dynamic item) {
    if (item is UserModel) return item.userName;
    return item.toString();
  }

  Color _getItemColor(dynamic item) {
    if (item is UserModel) {
      return Color(int.parse(item.color.replaceAll("#", "0xFF")));
    }
    return Colors.blue;
  }

  void close() {
    if (isOpen) {
      dropdown!.remove();
      isOpen = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: actionKey,
      onTap: () {
        if (isOpen) {
          close();
        } else {
          findDropDownData();
          dropdown = _createDropDown();
          Overlay.of(context).insert(dropdown!);
          isOpen = true;
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: isOpen ? Pallet.font1 : Colors.transparent),
        ),
        child: Row(
          children: [
            if (widget.selected.isEmpty)
              Text(
                "Select...",
                style: TextStyle(color: Pallet.font3, fontSize: 12),
              )
            else
              Expanded(
                child: Wrap(
                  spacing: 5,
                  children: [
                    for (var user in widget.selected)
                      ProfileIcon(
                        name: _getItemName(user),
                        color: _getItemColor(user),
                        size: 20,
                        fontSize: 8,
                      ),
                  ],
                ),
              ),
            Icon(Icons.arrow_drop_down, color: Pallet.font3),
          ],
        ),
      ),
    );
  }
}

class Options extends StatefulWidget {
  const Options({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelect,
    this.width = 150,
  });
  final List<dynamic> items;
  final dynamic selected;
  final Function(dynamic) onSelect;
  final double width;

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  double height = 0, width = 0, initX = 0, initY = 0;
  GlobalKey actionKey = GlobalKey();
  OverlayEntry? dropdown;
  bool isOpen = false;

  void findDropDownData() {
    RenderBox renderBox =
        actionKey.currentContext!.findRenderObject() as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    initX = offset.dx;
    initY = offset.dy;
  }

  OverlayEntry _createDropDown() {
    return OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            close();
          },
          child: Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  left: initX,
                  top: initY + height + 2,
                  child: GestureDetector(
                    onTap: () {},
                    child: Material(
                      shadowColor: Colors.transparent,
                      elevation: 1,
                      color: Colors.transparent,
                      child: GlassMorph(
                        width: widget.width,
                        borderRadius: 5,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 250),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              for (var item in widget.items)
                                InkWell(
                                  onTap: () {
                                    widget.onSelect(item);
                                    close();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: widget.selected == item
                                          ? Pallet.font1.withValues(alpha: 0.1)
                                          : Colors.transparent,
                                    ),
                                    child: Text(
                                      _getItemName(item),
                                      style: TextStyle(
                                        color: widget.selected == item
                                            ? Pallet.font1
                                            : Pallet.font3,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getItemName(dynamic item) {
    if (item is StatusModel) return item.statusName;
    if (item is PriorityModel) return item.priorityName;
    if (item is TypeModel) return item.typeName;
    if (item is UserTypes) return item.userType;
    if (item is LeaveConfig) return item.configName;
    if (item is SystemColor) return item.colorName ?? item.color;
    return item.toString();
  }

  void close() {
    if (isOpen) {
      dropdown!.remove();
      isOpen = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: actionKey,
      onTap: () {
        if (isOpen) {
          close();
        } else {
          findDropDownData();
          dropdown = _createDropDown();
          Overlay.of(context).insert(dropdown!);
          isOpen = true;
          setState(() {});
        }
      },
      child: Container(
        width: widget.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: isOpen ? Pallet.font1 : Colors.transparent),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.selected != null
                    ? _getItemName(widget.selected)
                    : "Select...",
                style: TextStyle(
                  color: widget.selected != null ? Pallet.font1 : Pallet.font3,
                  fontSize: 12,
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Pallet.font3, size: 20),
          ],
        ),
      ),
    );
  }
}

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
