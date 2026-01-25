import 'package:flutter/material.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../../../main.dart'; // For client
import '../../../../widgets/widgets.dart';
import '../../../../config/palette.dart';

class AddController extends StatefulWidget {
  const AddController({super.key, required this.type});
  final String type; // "status", "type", "priority"

  @override
  State<AddController> createState() => _AddControllerState();
}

class _AddControllerState extends State<AddController> {
  TextEditingController name = TextEditingController();
  UuidValue? selectedColorId;
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
                      elevation: 60,
                      color: Colors.transparent,
                      child: Container(
                        width: 220,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Pallet.inside3, // Closer match to popup
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                                        null,
                                        name.text,
                                      );
                                    } else if (widget.type == "type") {
                                      if (selectedColorId != null) {
                                        await client.planner.addTicketType(
                                          null,
                                          name.text,
                                          selectedColorId!,
                                        );
                                      } else {
                                        return;
                                      }
                                    } else if (widget.type == "priority") {
                                      await client.planner.addPriority(
                                        null,
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
    return AddButton(
      key: actionKey,
      onPress: () {
        if (isOpen) {
          dropdown?.remove();
        } else {
          findDropDownData();
          dropdown = _createDropDown();
          Overlay.of(context).insert(dropdown!);
        }

        isOpen = !isOpen;
        setState(() {});
      },
    );
  }
}
