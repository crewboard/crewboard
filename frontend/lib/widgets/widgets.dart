import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/services/arri_client.rpc.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/glass_morph.dart';
import 'package:frontend/widgets/textbox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/backend/server.dart';

// import '../backend/server.dart'; // TODO: Re-enable when server methods are implemented
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math' as math;

class AddController extends StatefulWidget {
  const AddController({
    super.key,
    this.showColor = false,
    required this.onSave,
  });
  final bool showColor;
  final Function onSave;
  @override
  State<AddController> createState() => _AddControllerState();
}

class _AddControllerState extends State<AddController> {
  TextEditingController name = TextEditingController();

  double height = 0, width = 0, initX = 0, initY = 0;
  GlobalKey actionKey = GlobalKey();
  OverlayEntry? dropdown;
  bool isOpen = false;
  String? selectedColor;

  @override
  void initState() {
    super.initState();
    _loadDefaultColor();
  }

  Future<void> _loadDefaultColor() async {
    try {
      final response = await server.admin.system.getColors(
        AdminSystemGetColorsParams(k_default: true),
      );
      if (response.k_default.isNotEmpty) {
        // final colorHex = response.k_default.first.color;
        selectedColor = response.k_default.first.colorId;
        setState(() {});
      }
    } catch (e) {
      // Handle error if needed
    }
  }

  close() {
    if (isOpen) {
      dropdown!.remove();
      isOpen = false;
      setState(() {});
    }
  }

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

  OverlayEntry _createDropDown() {
    return OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            // Close overlay when tapping outside the menu
            close();
          },
          child: Container(
            color: Colors.black.withOpacity(0.1),
            child: Stack(
              children: [
                Positioned(
                  left: initX,
                  top: initY + height + 5,
                  child: GestureDetector(
                    onTap: () {
                      // Prevent closing when tapping inside the menu
                    },
                    child: Material(
                      shadowColor: Colors.transparent,
                      elevation: 1,
                      color: Colors.transparent,
                      child: GlassMorph(
                        width: 220,
                        borderRadius: 10,
                        padding: EdgeInsets.all(10),
                        // decoration: BoxDecoration(
                        //   color: Pallet.inside1,
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text("Name", style: TextStyle(fontSize: 12)),
                            SizedBox(height: 10),
                            SmallTextBox(
                              controller: name,
                              onEnter: (value) {
                                // widget.onSave(value);
                                // close(); // Close overlay after saving
                              },
                            ),
                            SizedBox(height: 10),
                            if (widget.showColor)
                              Row(
                                children: [
                                  ColorPicker(
                                    color: Colors.red,
                                    onSelect: (color) {
                                      selectedColor = color;
                                      setState(() {});
                                    },
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
                                SizedBox(width: 10),
                                SmallButton(
                                  label: "done",
                                  onPress: () async {
                                    // save();
                                    if (widget.showColor) {
                                      widget.onSave(name.text, selectedColor);
                                    } else {
                                      widget.onSave(name.text);
                                    }
                                    close(); // Close overlay after saving
                                  },
                                ),
                              ],
                            ),
                          ],
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isOpen) {
          dropdown!.remove();
        } else {
          findDropDownData();
          dropdown = _createDropDown();
          Overlay.of(context).insert(dropdown!);
        }

        isOpen = !isOpen;
        setState(() {});
      },
      child: Container(
        key: actionKey,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey),
        ),
        child: Icon(Icons.add, color: Colors.grey, size: 10),
      ),
    );
  }
}

class AppListItem extends StatelessWidget {
  const AppListItem({
    super.key,
    required this.app,
    required this.isSelected,
    required this.onTap,
  });

  final App app;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Pallet.inside1 : Pallet.inside2,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Color(int.parse(app.color)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  app.appName.isNotEmpty ? app.appName[0].toUpperCase() : '',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(app.appName, style: TextStyle(color: Pallet.font2)),
          ],
        ),
      ),
    );
  }
}

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
    this.image,
    this.name,
    this.color,
    required this.size,
    this.fontSize,
  });
  final String? image;
  final String? name;
  final Color? color;
  final double size;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size),
        ),
        child: Center(
          child: Text(
            name![0].toString().toUpperCase(),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          // width: size,
          // height: size,
          // decoration: BoxDecoration(color: color, borderRadius: ),
          child: Image.network(image!), // TODO: Fix server.getAsssetUrl method
          // child: Center(
          // child: Text(name![0].toString().toUpperCase(), style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500))),
          // ),
        ),
      );
    }
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onPress});
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Pallet.font1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(Icons.add, size: 12),
      ),
    );
  }
}

class CustomBadge extends StatelessWidget {
  const CustomBadge({super.key, required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(5),
        color: color.withOpacity(0.2),
      ),
      child: Center(
        child: Text(label, style: TextStyle(fontSize: 12, color: color)),
      ),
    );
  }
}

// class SmallButton extends StatelessWidget {
//   const SmallButton({super.key, required this.label, required this.onPress});
//   final String label;
//   final Function onPress;
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: TextButton.styleFrom(
//         padding: EdgeInsets.all(0),
//         minimumSize: Size(30, 30),
//       ),
//       onPressed: () {
//         onPress();
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         decoration: BoxDecoration(
//           color: Pallet.inside1,
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Center(
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(color: Pallet.font3, fontSize: 12),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.color, required this.onSelect});
  final Color? color;
  final Function onSelect;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  GlobalKey actionKey = GlobalKey();
  double height = 0, width = 0, initX = 0, initY = 0;
  OverlayEntry? dropdown;
  bool isOpen = false;
  static ValueNotifier<bool> adding = ValueNotifier<bool>(false);
  TextEditingController color = TextEditingController();

  late Color selectedColor;
  bool wasEmpty = false;
  @override
  void initState() {
    if (widget.color == null) {
      selectedColor = Colors.red;
      wasEmpty = true;
    } else {
      selectedColor = widget.color!;
    }
    getData();
    super.initState();
  }

  void getDropDownData() {
    RenderBox renderBox =
        actionKey.currentContext!.findRenderObject() as RenderBox;
    height = 200;
    width = 200;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    initX = offset.dx;
    initY = offset.dy;
  }

  void close() {
    if (isOpen) {
      dropdown!.remove();
      isOpen = false;
    }
  }

  List defaultColors = [];
  List customColors = [];
  getData() async {
    try {
      final response = await server.admin.system.getColors(
        AdminSystemGetColorsParams(k_default: null),
      );
      defaultColors = response.k_default
          .map((color) => {"color": color.color, "colorId": color.colorId})
          .toList();
      customColors = response.custom
          .map((color) => {"color": color.color, "colorId": color.colorId})
          .toList();
      if (defaultColors.isNotEmpty && wasEmpty) {
        selectedColor = Color(int.parse(defaultColors.first["color"]));
      }
      adding.notifyListeners();
      setState(() {});
    } catch (e) {
      print("Error fetching colors: $e");
    }
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
                Positioned(
                  top: initY,
                  left: initX - (width / 2),
                  width: width,
                  height: height,
                  child: Material(
                    color: Colors.transparent,
                    elevation: 10,
                    child: GestureDetector(
                      onTap: () {},
                      behavior: HitTestBehavior.opaque,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: adding,
                        builder: (BuildContext context, bool _, Widget? child) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Pallet.inside1,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 160,
                            height: 160,
                            child: ListView(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (adding.value)
                                      Expanded(
                                        child: Container(
                                          // eddited for mobile
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Pallet.inside3,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  controller: color,
                                                  // focusNode: focus,
                                                  // onSubmitted: onEnter,
                                                  // onChanged: onType,
                                                  // controller: controller,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  // maxLines: maxLines ?? 1,
                                                  decoration: InputDecoration(
                                                    // hintText: hintText,
                                                    hintStyle: TextStyle(
                                                      fontSize: 12,
                                                      color: Pallet.font3,
                                                    ),
                                                    isDense: true,
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  adding.value = false;
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.close,
                                                  size: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    SizedBox(width: 5),
                                    AddButton(
                                      onPress: () async {
                                        if (adding.value) {
                                          String hash = color.text.replaceAll(
                                            "#",
                                            "",
                                          );
                                          if (hash.length == 6) {
                                            hash = "0xFF" + hash;
                                          }
                                          try {
                                            await server.admin.system.addColor(
                                              AddColorParams(color: hash),
                                            );
                                            await getData(); // Refresh colors after adding
                                          } catch (e) {
                                            print("Error adding color: $e");
                                          }
                                        } else {
                                          adding.value = true;
                                          setState(() {});
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     AddButton(
                                //       onPress: () {},
                                //     ),
                                //   ],
                                // ),
                                // TextField(
                                //   style: TextStyle(fontSize: 10),
                                //   decoration: InputDecoration(
                                //     hintStyle: TextStyle(fontSize: 12, color: Pallet.font3),
                                //     isDense: true,
                                //   ),
                                //   onChanged: (text) {},
                                // ),
                                Text("colors", style: TextStyle(fontSize: 12)),
                                SizedBox(height: 10),
                                Wrap(
                                  children: [
                                    for (var color in defaultColors)
                                      InkWell(
                                        onTap: () {
                                          selectedColor = Color(
                                            int.parse(color["color"]),
                                          );
                                          widget.onSelect(color);
                                          close();
                                          setState(() {});
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          width: 26,
                                          height: 26,
                                          decoration: BoxDecoration(
                                            color: Color(
                                              int.parse(color["color"]),
                                            ),
                                            // color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                if (customColors.isNotEmpty)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "colors",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(height: 10),
                                      Wrap(
                                        children: [
                                          for (var color in customColors)
                                            InkWell(
                                              onTap: () {
                                                selectedColor = Color(
                                                  int.parse(color["color"]),
                                                );
                                                widget.onSelect(color);
                                                close();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(5),
                                                width: 26,
                                                height: 26,
                                                decoration: BoxDecoration(
                                                  color: Color(
                                                    int.parse(color["color"]),
                                                  ),
                                                  // color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          );
                        },
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!isOpen) {
          if (defaultColors.isEmpty) {
            await getData();
          }
          getDropDownData();
          dropdown = _createDropDown();
          Overlay.of(context).insert(dropdown!);
        } else {
          close();
        }
        isOpen = !isOpen;
        setState(() {});
      },
      child: Container(
        key: actionKey,
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: selectedColor,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class MultiSelect extends StatefulWidget {
  const MultiSelect({
    super.key,
    required this.label,
    required this.items,
    required this.itemKey,
    required this.onChanged,
    // required this.onPress,
    this.itemHeight = 40,
    this.menuDecoration,
  });
  final String label;
  final List<dynamic> items;
  final String itemKey;
  final double itemHeight;
  final BoxDecoration? menuDecoration;
  final Function onChanged;
  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
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
        return GestureDetector(
          onTap: () {
            print("here");
            close();
          },
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                  left: initX,
                  width: width,
                  top: initY + height + 5,
                  height:
                      widget.itemHeight *
                      (widget.items.length > 5 ? 5 : widget.items.length),
                  child: Material(
                    elevation: 60,
                    color: Colors.transparent,
                    child: ValueListenableBuilder<int?>(
                      valueListenable: hoveredIdx,
                      builder: (BuildContext context, int? _hoveredIdx, Widget? child) {
                        return Container(
                          constraints: BoxConstraints(
                            maxHeight: widget.itemHeight * 4,
                          ),
                          // decoration: widget.menuDecoration,
                          child: GlassMorph(
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
                                        widget.items[i] = widget.items[i]
                                            .copyWith(
                                              selected:
                                                  !widget.items[i].selected,
                                            );

                                        setState(() {});

                                        widget.onChanged(widget.items[i]);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: (i == _hoveredIdx)
                                              ? Pallet.inside1
                                              : Colors.transparent,
                                        ),
                                        height: widget.itemHeight,
                                        child: Row(
                                          children: [
                                            SizedBox(width: 5),
                                            ProfileIcon(
                                              size: 25,
                                              name: widget.items[i]
                                                  .toJson()["userName"],
                                              color: Color(
                                                int.parse(
                                                  widget.items[i]
                                                      .toJson()["color"],
                                                ),
                                              ),
                                              // color: Color(int.parse(item["color"].toString(), radix: 16)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: Text(
                                                widget.items[i]
                                                    .toJson()["userName"],
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Expanded(child: SizedBox()),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(),
                                            ),
                                            Checkbox(
                                              activeColor: Pallet.inside1,
                                              value: widget.items[i]
                                                  .toJson()["selected"],
                                              onChanged: (value) {
                                                // widget.items[i].copyWith(
                                                //   selected: value,
                                                // );
                                                // widget.items[i]["selected"] =
                                                // value;
                                                setState(
                                                  () {},
                                                ); // Trigger rebuild instead of notifyListeners
                                                widget.onChanged(
                                                  widget.items[i],
                                                );

                                                // if (item["selected"] == true) {
                                                //   item["selected"] = false;
                                                //   for (var i = 0; i < ticket.selectedUsers.length; i++) {
                                                //     if (item["userId"] == ticket.selectedUsers[i]["userId"]) {
                                                //       ticket.selectedUsers.removeAt(i);
                                                //     }
                                                //   }
                                                // } else {
                                                //   ticket.selectedUsers.add(item);
                                                //   item["selected"] = true;
                                                // }
                                                // item["selected"] = value;
                                                // notifier.notifyListeners();

                                                // refreshSink.add("");
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isOpen) {
          dropdown!.remove();
        } else {
          findDropDownData();
          dropdown = _createDropDown();
          Overlay.of(context).insert(dropdown!);
        }

        isOpen = !isOpen;
        setState(() {});
      },
      child: Container(
        key: actionKey,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [Text(widget.label, style: TextStyle(fontSize: 12))],
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPress,
    required this.label,
  });
  final Function onPress;
  final String label;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
        // Window.subPage.value = name;
      },
      child: Container(
        decoration: BoxDecoration(
          color: Pallet.inside1,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 27, 27, 27),
              offset: Offset(-1, -1),
              blurRadius: 4,
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 63, 63, 63),
              offset: Offset(1, 1),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Pallet.font2, fontSize: 12),
          ),
        ),
      ),
    );
  }
}

class Options extends StatefulWidget {
  const Options({super.key, required this.items, required this.onSelect});
  final List<String> items;
  final Function onSelect;

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  double height = 0, width = 0, initX = 0, initY = 0;
  GlobalKey actionKey = GlobalKey();
  OverlayEntry? dropdown;
  bool isOpen = false;
  int? colordId;
  static ValueNotifier<int?> selectedIdx = ValueNotifier<int?>(null);

  // bool adding = false;
  close() {
    if (isOpen) {
      dropdown!.remove();
      isOpen = false;
      setState(() {});
    }
  }

  void findDropDownData() {
    RenderBox renderBox =
        actionKey.currentContext!.findRenderObject() as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    // Offset offset = renderBox.localToGlobal(Offset.zero);
    Offset offset = renderBox.localToGlobal(Offset.zero);
    initX = offset.dx - 80;
    initY = offset.dy - height;
    print(initX);
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
                    top: initY,
                    child: Material(
                      elevation: 60,
                      color: Colors.transparent,
                      child: ValueListenableBuilder<int?>(
                        valueListenable: selectedIdx,
                        builder: (BuildContext context, int? _, Widget? child) {
                          return Container(
                            width: 100,
                            // padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Pallet.inside2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var i = 0; i < widget.items.length; i++)
                                  // for (var item in widget.items)
                                  MouseRegion(
                                    onEnter: (details) {
                                      selectedIdx.value = i;
                                    },
                                    onExit: (details) {
                                      selectedIdx.value = null;
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        widget.onSelect(widget.items[i]);
                                        close();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: (selectedIdx.value == i)
                                              ? Pallet.inside3
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        width: 100,
                                        height: 40,
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10),
                                            Text(
                                              widget.items[i],
                                              style: TextStyle(fontSize: 12),
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
          Overlay.of(context).insert(dropdown!);
        }

        isOpen = !isOpen;
        setState(() {});
      },
      child: Container(
        key: actionKey,
        decoration: BoxDecoration(
          border: Border.all(color: Pallet.font3),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(Icons.more_horiz, color: Pallet.font3, size: 15),
      ),
    );
  }
}

class FilePreview extends StatelessWidget {
  const FilePreview({
    super.key,
    required this.name,
    required this.size,
    this.url,
  });
  final String name;
  final int size;
  final String? url;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallet.inside2,
        borderRadius: BorderRadius.circular(12),
      ),
      // decoration: BoxDecoration(color: Pallet.inside3, borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallet.font3.withOpacity(0.5))),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      constraints: BoxConstraints(maxWidth: 200),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 35,
            height: 42,
            child: Stack(
              children: [
                SvgPicture.asset(
                  getFileColor(name.split(".").last.toLowerCase()),
                  width: 35,
                  height: 42,
                  fit: BoxFit.fill,
                ),
                Center(
                  child: Text(
                    name.split(".").last,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 3),
                Text(
                  getSize(size),
                  style: TextStyle(fontSize: 10, color: Pallet.font3),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          InkWell(onTap: () {}, child: Icon(Icons.download, size: 20)),
          SizedBox(width: 8),
        ],
      ),
    );
  }

  getSize(int size) {
    double _size = size / 1048576;
    if (_size < 1) {
      _size = _size * 1000;
      return _size.toStringAsFixed(2) + " KB";
    } else if (_size < 1000) {
      return _size.toStringAsFixed(2) + " MB";
    } else {
      _size = _size / 1000;
      return _size.toStringAsFixed(2) + " GB";
    }
  }

  getFileColor(String fileType) {
    List<String> green = ["xlsx", "xls", "csv", "py", "apk"];
    List<String> red = ["pdf", "ppt", "pptx", "odp"];
    List<String> yellow = ["html", "ipa"];
    if (green.contains(fileType)) {
      return "assets/files/green.svg";
    } else if (red.contains(fileType)) {
      return "assets/files/red.svg";
    } else if (yellow.contains(fileType)) {
      return "assets/files/yellow.svg";
    } else {
      return "assets/files/blue.svg";
    }
  }
}

class AudioPreview extends StatefulWidget {
  const AudioPreview({
    super.key,
    required this.url,
    required this.color,
    this.localUrl,
  });
  final String url;
  final Color color;
  final bool? localUrl;
  @override
  State<AudioPreview> createState() => _AudioPreviewState();
}

class _AudioPreviewState extends State<AudioPreview> {
  final _player = AudioPlayer();
  ValueNotifier<bool> playing = ValueNotifier<bool>(false);
  List<double> noises = [];
  double noiseHeight = 50;
  double noiseWidth = 200;
  @override
  void initState() {
    for (int i = 0; i < (noiseWidth / 10).toInt(); i++) {
      noises.add((50 - 20) * math.Random().nextDouble());
    }
    _init();
    super.initState();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    try {
      if (widget.localUrl == true) {
        await _player.setFilePath(widget.url);
      } else {
        await _player.setAudioSource(
          AudioSource.uri(Uri.parse(widget.url)),
        ); // TODO: Fix server.getAsssetUrl method
      }
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 60,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: playing,
            builder: (BuildContext context, bool isPlaying, Widget? child) {
              return InkWell(
                onTap: () {
                  if (isPlaying) {
                    _player.stop();
                    playing.value = false;
                  } else {
                    _player.play();
                    playing.value = true;
                  }
                },
                child: Icon((isPlaying) ? Icons.pause : Icons.play_arrow),
              );
            },
          ),
          SizedBox(width: 10),
          StreamBuilder<PositionData>(
            stream: _positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              if (positionData != null) {
                return SeekBar(
                  width: 200,
                  height: 50,
                  noises: noises,
                  duration: positionData.duration,
                  position: positionData.position,
                  bufferedPosition: positionData.bufferedPosition,
                  onChangeEnd: _player.seek,
                );
              }

              return SizedBox(width: 200, height: 50);
            },
          ),
        ],
      ),
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;
  final double width;
  final double height;
  final List<double> noises;
  const SeekBar({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    required this.width,
    required this.height,
    required this.noises,
    this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  // double? _dragValue; // Unused field
  late SliderThemeData _sliderThemeData;
  int passed = 0;
  @override
  void initState() {
    passed =
        (widget.position.inSeconds /
                (widget.duration.inSeconds / (widget.width / 10).toInt())
                    .toInt())
            .toInt();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(trackHeight: 2.0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          SizedBox(
            width: widget.width,
            height: widget.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < widget.noises.length; i++)
                  Container(
                    width: 5,
                    height: widget.noises[i],
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: i < passed ? Pallet.font1 : Pallet.font3,
                    ),
                  ),
              ],
            ),
          ),
          SliderTheme(
            data: _sliderThemeData.copyWith(
              activeTrackColor: Colors.transparent,
              thumbColor: Colors.transparent,
              disabledActiveTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              overlayColor: Colors.transparent,
              trackShape: CustomTrackShape(width: widget.width),
              thumbShape: SliderComponentShape.noThumb,
              minThumbSeparation: 0,
            ),
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  // _dragValue = value; // Unused field
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                // _dragValue = null; // Unused field
              },
              value: math.min(
                widget.bufferedPosition.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble(),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              RegExp(
                    r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$',
                  ).firstMatch("$_remaining")?.group(1) ??
                  '$_remaining',
              style: TextStyle(color: Pallet.font3, fontSize: 8),
            ),
          ),
        ],
      ),
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  CustomTrackShape({required this.width});
  double width;

  /// document will be added
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double trackHeight = 10;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  // TODO: Replace these two by ValueStream.
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 100.0,
          child: Column(
            children: [
              Text(
                '${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                style: const TextStyle(
                  fontFamily: 'Fixed',
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class ChipButton extends StatelessWidget {
  const ChipButton({super.key, required this.name, required this.onPress});
  final String name;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Pallet.font3),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(color: Pallet.font3, fontSize: 11.8),
          ),
        ),
      ),
    );
  }
}
