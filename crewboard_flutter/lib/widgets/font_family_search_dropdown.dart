import 'package:flutter/material.dart';
import 'package:crewboard_flutter/config/palette.dart';
import 'package:crewboard_flutter/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class FontFamilySearchDropdown extends StatefulWidget {
  const FontFamilySearchDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.fontFamily,
  });

  final String value;
  final List<String> items;
  final Function(String) onChanged;
  final String? fontFamily;

  @override
  State<FontFamilySearchDropdown> createState() => _FontFamilySearchDropdownState();
}

class _FontFamilySearchDropdownState extends State<FontFamilySearchDropdown> {
  double height = 0, width = 0, initX = 0, initY = 0;
  GlobalKey actionKey = GlobalKey();
  OverlayEntry? dropdown;
  bool isOpen = false;
  final ValueNotifier<int?> hoveredIdx = ValueNotifier<int?>(null);
  final TextEditingController searchController = TextEditingController();
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  @override
  void didUpdateWidget(covariant FontFamilySearchDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      filteredItems = widget.items;
    }
  }

  void findDropDownData() {
    RenderBox renderBox = actionKey.currentContext!.findRenderObject() as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    initX = offset.dx;
    initY = offset.dy;
  }

  void close() {
    if (isOpen) {
      dropdown!.remove();
      isOpen = false;
      searchController.clear();
      filteredItems = widget.items;
      setState(() {});
    }
  }

  OverlayEntry _createDropDown() {
    return OverlayEntry(
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setOverlayState) {
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
                        width: 250, // Wider overlay
                        top: initY + height + 5,
                        child: Material(
                          elevation: 60,
                          color: Colors.transparent,
                          child: GlassMorph(
                            borderRadius: 10,
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SmallTextBox(
                                  controller: searchController,
                                  hintText: "Search font...",
                                  onType: (val) {
                                    setOverlayState(() {
                                      filteredItems = widget.items
                                          .where((f) => f.toLowerCase().contains(val.toLowerCase()))
                                          .toList();
                                    });
                                  },
                                ),
                                const SizedBox(height: 8),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: 250, // Limit height
                                  ),
                                  child: ValueListenableBuilder<int?>(
                                    valueListenable: hoveredIdx,
                                    builder: (context, _hoveredIdx, child) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: filteredItems.length,
                                        itemBuilder: (context, i) {
                                          final font = filteredItems[i];
                                          return MouseRegion(
                                            onEnter: (details) => hoveredIdx.value = i,
                                            onExit: (details) => hoveredIdx.value = null,
                                            child: InkWell(
                                              onTap: () {
                                                widget.onChanged(font);
                                                close();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: (i == _hoveredIdx)
                                                      ? Pallet.inside1
                                                      : Colors.transparent,
                                                ),
                                                height: 40,
                                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        font,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Pallet.font2,
                                                          fontFamily: font, // Sample style
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
                                    },
                                  ),
                                ),
                              ],
                            ),
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
      },
    );
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
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Pallet.divider, width: 1),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8),
            Text(
              widget.value,
              style: TextStyle(
                fontSize: 12,
                color: Pallet.font2,
                fontFamily: widget.fontFamily,
              ),
            ),
            const SizedBox(width: 2),
            Icon(Icons.arrow_drop_down_sharp, color: Pallet.font3),
          ],
        ),
      ),
    );
  }
}
