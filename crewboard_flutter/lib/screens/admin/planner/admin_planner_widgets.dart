import 'package:flutter/material.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../../../main.dart'; // For client
import '../../../../widgets/widgets.dart';
import '../../../../config/palette.dart';

class AddController extends StatefulWidget {
  const AddController({
    super.key,
    required this.type,
    this.id,
    this.initialName,
    this.initialColorId,
    this.initialWorking,
    this.initialCompleted,
    this.child,
  });
  final String type; // "status", "type", "priority"
  final UuidValue? id;
  final String? initialName;
  final UuidValue? initialColorId;
  final bool? initialWorking;
  final bool? initialCompleted;
  final Widget? child;

  @override
  State<AddController> createState() => _AddControllerState();
}

class _AddControllerState extends State<AddController> {
  late TextEditingController name;
  UuidValue? selectedColorId;
  bool working = false;
  bool completed = false;
  double height = 0, width = 0, initX = 0, initY = 0;
  GlobalKey actionKey = GlobalKey();
  OverlayEntry? dropdown;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.initialName);
    selectedColorId = widget.initialColorId;
    working = widget.initialWorking ?? false;
    completed = widget.initialCompleted ?? false;
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

  void close() {
    if (isOpen) {
      dropdown?.remove();
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
              color: Colors.black.withOpacity(0.1),
              child: Stack(
                children: [
                  Positioned(
                    left: initX,
                    top: initY + height + 5,
                    child: Material(
                      color: Colors.transparent,
                      child: GlassMorph(
                        width: 220,
                        padding: const EdgeInsets.all(10),
                        borderRadius: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 12,
                                color: Pallet.font1,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SmallTextBox(
                              controller: name,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (widget.type == "type")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Color",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Pallet.font1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ColorPicker(
                                    selectedColorId: selectedColorId,
                                    onColorSelected: (systemColor) {
                                      setState(() {
                                        selectedColorId = systemColor.id;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            if (widget.type == "status")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildToggleRow("Working", working, (val) {
                                    setState(() => working = val);
                                  }),
                                  const SizedBox(height: 10),
                                  _buildToggleRow("Completed", completed, (
                                    val,
                                  ) {
                                    setState(() => completed = val);
                                  }),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SmallButton(
                                  label: "close",
                                  onPress: () {
                                    close();
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SmallButton(
                                  label: "done",
                                  onPress: () async {
                                    if (name.text.isEmpty) return;

                                    if (widget.type == "status") {
                                      await client.planner.addStatus(
                                        widget.id,
                                        name.text,
                                        working,
                                        completed,
                                      );
                                    } else if (widget.type == "type") {
                                      if (selectedColorId != null) {
                                        await client.planner.addTicketType(
                                          widget.id,
                                          name.text,
                                          selectedColorId!,
                                        );
                                      } else {
                                        return;
                                      }
                                    } else if (widget.type == "priority") {
                                      await client.planner.addPriority(
                                        widget.id,
                                        name.text,
                                      );
                                    }

                                    refreshSink.add("get_admin_planner_data");
                                    name.clear();
                                    close();
                                  },
                                ),
                              ],
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
  }

  @override
  Widget build(BuildContext context) {
    final VoidCallback onTap = () {
      if (isOpen) {
        dropdown?.remove();
      } else {
        findDropDownData();
        dropdown = _createDropDown();
        Overlay.of(context).insert(dropdown!);
      }

      isOpen = !isOpen;
      setState(() {});
    };

    if (widget.child != null) {
      return InkWell(
        key: actionKey,
        onTap: onTap,
        child: widget.child!,
      );
    }

    return AddButton(
      key: actionKey,
      onPress: onTap,
    );
  }

  Widget _buildToggleRow(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Pallet.font1,
          ),
        ),
        Transform.scale(
          scale: 0.7,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
          ),
        ),
      ],
    );
  }
}
