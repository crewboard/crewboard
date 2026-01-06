import 'package:flutter/material.dart';
import '../config/palette.dart';
import 'glass_morph.dart';

class DropDown extends StatefulWidget {
  const DropDown({
    super.key,
    required this.label,
    required this.items,
    required this.itemKey,
    required this.onPress,
    this.itemHeight = 40,
    this.menuDecoration,
  });

  final String label;
  final List<dynamic> items;
  final String itemKey;
  final double itemHeight;
  final BoxDecoration? menuDecoration;
  final Function(dynamic) onPress;
  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  double height = 0, width = 0, initX = 0, initY = 0;
  GlobalKey actionKey = GlobalKey();
  OverlayEntry? dropdown;
  bool isOpen = false;
  bool selected = false;
  final ValueNotifier<int?> hoveredIdx = ValueNotifier<int?>(null);

  void findDropDownData() {
    RenderBox renderBox =
        actionKey.currentContext!.findRenderObject() as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    initX = offset.dx;
    initY = offset.dy;
  }

  close() {
    if (isOpen) {
      dropdown!.remove();
      isOpen = false;
      if (mounted) setState(() {});
    }
  }

  OverlayEntry _createDropDown() {
    return OverlayEntry(
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GestureDetector(
            onTap: () {
              close();
            },
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    left: initX,
                    width: width,
                    top: initY + height + 5,
                    height:
                        widget.itemHeight *
                        ((widget.items.length > 4) ? 4 : widget.items.length),
                    child: Material(
                      elevation: 60,
                      color: Colors.transparent,
                      child: ValueListenableBuilder<int?>(
                        valueListenable: hoveredIdx,
                        builder:
                            (
                              BuildContext context,
                              int? _hoveredIdx,
                              Widget? child,
                            ) {
                              return GlassMorph(
                                borderRadius: 10,
                                child: ListView(
                                  children: [
                                    for (
                                      var i = 0;
                                      i < widget.items.length;
                                      i++
                                    )
                                      MouseRegion(
                                        onEnter: (details) {
                                          hoveredIdx.value = i;
                                        },
                                        onExit: (details) {
                                          hoveredIdx.value = null;
                                        },
                                        child: InkWell(
                                          onTap: () {
                                            widget.onPress(widget.items[i]);
                                            selected = true;
                                            close();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: (i == _hoveredIdx)
                                                  ? Pallet.inside1
                                                  : Colors.transparent,
                                            ),
                                            height: widget.itemHeight,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 10.0,
                                                      ),
                                                  child: Text(
                                                    _getItemValue(
                                                      widget.items[i],
                                                      widget.itemKey,
                                                    ),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Pallet.font1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getItemValue(dynamic item, String key) {
    if (item is Map) {
      return item[key]?.toString() ?? "";
    }
    try {
      // Handle objects with toJson
      final json = item.toJson();
      return json[key]?.toString() ?? "";
    } catch (e) {
      return item.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    _updateSelection();
  }

  @override
  void didUpdateWidget(DropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSelection();
  }

  void _updateSelection() {
    selected = false;
    for (var item in widget.items) {
      if (_getItemValue(item, widget.itemKey) == widget.label) {
        selected = true;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
        key: actionKey,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.label,
                style: const TextStyle(fontSize: 12, color: Pallet.font1),
              ),
            ),
            Container(
              width: 4,
              height: 15,
              decoration: BoxDecoration(
                color: (selected) ? Colors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
