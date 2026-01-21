import 'package:flutter/material.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/widgets/glass_morph.dart';

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
    // Offset offset = renderBox.localToGlobal(Offset.zero);
    Offset offset = renderBox.localToGlobal(Offset.zero);
    initX = offset.dx;
    initY = offset.dy;
    print(initX);
  }

  close() {
    if (isOpen) {
      dropdown!.remove();
      isOpen = false;
      setState(() {});
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
                                // decoration: BoxDecoration(color: Colors.blue),
                                // decoration: widget.menuDecoration,
                                child: ListView(
                                  children: [
                                    // for (var item in widget.items)
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
                                            print("object");
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
                                                        left: 8.0,
                                                      ),
                                                  child: Text(
                                                    widget.items[i]
                                                        .toJson()[widget
                                                        .itemKey],
                                                    style: TextStyle(
                                                      fontSize: 12,
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

  @override
  void initState() {
    for (var item in widget.items) {
      if (item.toJson()[widget.itemKey] == widget.label) {
        selected = true;
        setState(() {});
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isOpen) {
          dropdown!.remove();
        } else {
          findDropDownData();
          dropdown = _createDropDown();
          Overlay.of(context)!.insert(dropdown!);
        }

        isOpen = !isOpen;
        setState(() {});
      },
      child: Container(
        key: actionKey,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            SizedBox(width: 2),
            Expanded(child: Text(widget.label, style: TextStyle(fontSize: 12))),
            Container(
              width: 4,
              height: 20,
              color: (selected) ? Colors.green : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
