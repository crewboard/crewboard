import 'package:flutter/material.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../config/palette.dart';
import 'glass_morph.dart';

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
