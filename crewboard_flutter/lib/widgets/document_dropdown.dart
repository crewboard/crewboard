import 'package:flutter/material.dart';
import 'package:crewboard_flutter/config/palette.dart';
import 'package:crewboard_flutter/widgets/widgets.dart';

class DocumentDropdown extends StatefulWidget {
  const DocumentDropdown({
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
  State<DocumentDropdown> createState() => _DocumentDropdownState();
}

class _DocumentDropdownState extends State<DocumentDropdown> {
  double height = 0, width = 0, initX = 0, initY = 0;
  GlobalKey actionKey = GlobalKey();
  OverlayEntry? dropdown;
  bool isOpen = false;
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

  void close() {
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
                    height: 40.0 * ((widget.items.length > 4) ? 4 : widget.items.length),
                    child: Material(
                      elevation: 60,
                      color: Colors.transparent,
                      child: ValueListenableBuilder<int?>(
                        valueListenable: hoveredIdx,
                        builder: (BuildContext context, int? _hoveredIdx, Widget? child) {
                          return GlassMorph(
                            borderRadius: 10,
                            child: ListView(
                              children: [
                                for (var i = 0; i < widget.items.length; i++)
                                  MouseRegion(
                                    onEnter: (details) {
                                      hoveredIdx.value = i;
                                    },
                                    onExit: (details) {
                                      hoveredIdx.value = null;
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        widget.onChanged(widget.items[i]);
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
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                widget.items[i],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Pallet.font2,
                                                  fontFamily: widget.fontFamily,
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
      child:  Container(
          key: actionKey,
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          // constraints: const BoxConstraints(minWidth: 80),
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
              Icon(Icons.arrow_drop_down_sharp,color: Pallet.font3,)
            ],
          ),
      ),
    );
  }
}