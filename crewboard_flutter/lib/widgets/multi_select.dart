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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
