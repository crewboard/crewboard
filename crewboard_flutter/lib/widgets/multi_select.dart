import 'package:flutter/material.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../config/palette.dart';
import 'glass_morph.dart';
import 'profile_icon.dart';

class MultiSelect extends StatefulWidget {
  const MultiSelect({
    super.key,
    required this.items,
    required this.selected,
    this.width = 150,
    this.label = "Assignees",
    this.onChanged,
  });
  final List<dynamic> items;
  final List<dynamic> selected;
  final double width;
  final String label;
  final VoidCallback? onChanged;

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  double height = 0, width = 0, initX = 0, initY = 0;
  GlobalKey actionKey = GlobalKey();
  OverlayEntry? dropdown;
  bool isOpen = false;

  bool _isSelected(dynamic item) {
    if (item is UserModel) {
      return widget.selected.any(
        (element) => element is UserModel && element.userId == item.userId,
      );
    }
    return widget.selected.contains(item);
  }

  void _toggleSelection(dynamic item) {
    if (_isSelected(item)) {
      if (item is UserModel) {
        widget.selected.removeWhere(
          (element) => element is UserModel && element.userId == item.userId,
        );
      } else {
        widget.selected.remove(item);
      }
    } else {
      widget.selected.add(item);
    }
  }

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
                                    _toggleSelection(item);
                                    if (widget.onChanged != null) {
                                      widget.onChanged!();
                                    }
                                    setState(() {
                                      dropdown?.markNeedsBuild();
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _isSelected(item)
                                          ? Pallet.font1.withValues(alpha: 0.1)
                                          : Colors.transparent,
                                    ),
                                    child: Row(
                                      children: [
                                        ProfileIcon(
                                          name: _getItemName(item),
                                          color: _getItemColor(item),
                                          size: 18,
                                          fontSize: 8,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            _getItemName(item),
                                            style: TextStyle(
                                              color: Pallet.font1,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 16,
                                          width: 16,
                                          decoration: BoxDecoration(
                                            color: _isSelected(item)
                                                ? Pallet.inside3
                                                : Colors.transparent,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: _isSelected(item)
                                                  ? Pallet.inside3
                                                  : Pallet.font1.withValues(
                                                      alpha: 0.3,
                                                    ),
                                            ),
                                          ),
                                          child: _isSelected(item)
                                              ? Icon(
                                                  Icons.check,
                                                  color: Pallet.font1,
                                                  size: 10,
                                                )
                                              : null,
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
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.label,
                style: TextStyle(color: Pallet.font1, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
