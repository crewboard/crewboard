import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/globals.dart';

class SearchDropDown extends StatefulWidget {
  const SearchDropDown({
    super.key,
    this.decoration,
    this.menuDecoration,
    required this.items,
    required this.itemKey,
    required this.onSelect,
    required this.controller,
    this.itemHeight = 40,
  });
  final BoxDecoration? decoration;
  final BoxDecoration? menuDecoration;
  final List<Map> items;
  final String itemKey;
  final double itemHeight;
  final Function(Map) onSelect;
  final TextEditingController controller;

  @override
  State<SearchDropDown> createState() => _SearchDropDownState();
}

class _SearchDropDownState extends State<SearchDropDown> {
  bool isOpen = false;
  GlobalKey actionKey = GlobalKey();
  OverlayEntry? dropdown;
  double itemCount = 0;
  double maxItem = 4;
  int? selectedIdx;
  // double itemHeight = 40;
  double height = 0, width = 0, initX = 0, initY = 0;
  final ValueNotifier<List> _items = ValueNotifier<List>([]);
  final ScrollController controller = ScrollController();
  void _scrollDown() {
    double x = selectedIdx! - maxItem + 1;
    if (x < 0) {
      x = 0;
    }
    controller.animateTo(
      x * widget.itemHeight,
      duration: const Duration(microseconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _scrollUp() {
    double x = selectedIdx! - maxItem;
    if (x < 0) {
      x = 0;
    }
    controller.animateTo(
      x,
      duration: Duration(microseconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  search(String filter) {
    _items.value = [];

    if (filter != "") {
      for (var item in widget.items) {
        if (item[widget.itemKey].toString().toLowerCase().contains(
          filter.toLowerCase(),
        )) {
          _items.value.add(item);
        }
      }
    }
    print(_items.value);
  }

  @override
  void initState() {
    super.initState();
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
            width: Window.width,
            height: Window.height,
            child: Stack(
              children: [
                ValueListenableBuilder<List>(
                  valueListenable: _items,
                  builder: (BuildContext context, List items, Widget? child) {
                    return Positioned(
                      left: initX,
                      width: width,
                      top: initY + height + 5,
                      height: widget.itemHeight * itemCount,
                      child: Material(
                        elevation: 6,
                        color: Colors.transparent,
                        child: Container(
                          decoration: widget.menuDecoration,
                          constraints: BoxConstraints(
                            maxHeight: widget.itemHeight * 5,
                          ),
                          child: ListView.builder(
                            controller: controller,
                            itemCount: items.length,
                            itemBuilder: (_, i) => GestureDetector(
                              onTap: () {
                                widget.onSelect(items[i]);
                                widget.controller.text =
                                    items[i][widget.itemKey];
                                close();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (selectedIdx == i)
                                      ? Colors.white.withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: widget.itemHeight,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        items[i][widget.itemKey],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void getDropDownData() {
    RenderBox renderBox =
        actionKey.currentContext!.findRenderObject() as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    initX = offset.dx;
    initY = offset.dy;
  }

  void close() {
    if (isOpen = true) {
      selectedIdx = null;
      dropdown!.remove();
      isOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: actionKey,
      padding: EdgeInsets.all(8),
      decoration: widget.decoration,
      child: Row(
        children: [
          Expanded(
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (RawKeyEvent event) {
                if (event.runtimeType == RawKeyUpEvent &&
                    (event.logicalKey.keyId == 4294968065)) {
                  // down
                  if (selectedIdx == null) {
                    selectedIdx = 0;
                  } else if (_items.value.length > (selectedIdx! + 1)) {
                    selectedIdx = selectedIdx! + 1;
                  }
                  _scrollDown();
                }
                if (event.runtimeType == RawKeyUpEvent &&
                    (event.logicalKey.keyId == 4294968068)) {
                  // up
                  print(selectedIdx);
                  if (selectedIdx != null) {
                    if (selectedIdx == 0) {
                      selectedIdx = null;
                    } else {
                      selectedIdx = selectedIdx! - 1;
                      _scrollUp();
                    }
                  }
                }
                widget.controller.selection = TextSelection.collapsed(
                  offset: widget.controller.text.length,
                );
                _items.notifyListeners();
              },
              child: TextField(
                onSubmitted: (_) {
                  if (selectedIdx != null) {
                    widget.controller.text =
                        _items.value[selectedIdx!][widget.itemKey];
                    widget.onSelect(_items.value[selectedIdx!]);
                    close();
                  }
                },
                controller: widget.controller,
                style: const TextStyle(fontSize: 12),
                onChanged: (value) {
                  selectedIdx = null;
                  search(value);

                  itemCount = _items.value.length as double;
                  print(itemCount);
                  if (maxItem < itemCount) {
                    itemCount = maxItem;
                  }
                  if (itemCount == 0.0) {
                    close();
                  } else {
                    if (!isOpen) {
                      getDropDownData();
                      dropdown = _createDropDown();
                      print(dropdown);
                      Overlay.of(context).insert(dropdown!);
                      isOpen = true;
                    }
                  }
                  _items.notifyListeners();
                },
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          if (isOpen)
            GestureDetector(
              onTap: () {
                close();
              },
              child: Icon(Icons.close, size: 18, color: Pallet.font3),
            ),
        ],
      ),
    );
  }
}
