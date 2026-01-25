import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'backend/server.dart';
import 'types.dart';
// import 'package:audio_session/audio_session.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart';
import 'dart:math' as math;

class ProfileIcon extends StatelessWidget {
  const ProfileIcon(
      {super.key,
      this.image,
      this.name,
      this.color,
      required this.size,
      this.fontSize});
  final String? image;
  final String? name;
  final Color? color;
  final double size;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(size)),
      child: Center(
        child: Text(name![0].toString().toUpperCase(),
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: fontSize, fontWeight: FontWeight.w500))),
      ),
    );
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
            borderRadius: BorderRadius.circular(5)),
        child: Icon(
          Icons.add,
          size: 12,
        ),
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
        child: Text(
          label,
          style: TextStyle(fontSize: 12, color: color),
        ),
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  const TextBox(
      {super.key,
      this.controller,
      this.maxLines,
      this.onType,
      this.onEnter,
      this.hintText,
      this.focus,
      this.radius});
  final TextEditingController? controller;
  final int? maxLines;
  final Function(String)? onType;
  final Function(String)? onEnter;
  final String? hintText;
  final FocusNode? focus;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      // eddited for mobile
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Pallet.inner3,
        borderRadius: BorderRadius.circular(radius ?? 5),
      ),
      child: TextField(
          focusNode: focus,
          onSubmitted: onEnter,
          onChanged: onType,
          controller: controller,
          style: TextStyle(fontSize: 12),
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 12, color: Pallet.font3),
            isDense: true,
            border: InputBorder.none,
          )),
    );
  }
}

class Button extends StatelessWidget {
  const Button({super.key, required this.label, required this.onPress});
  final String label;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
          minimumSize: Size(30, 30),
        ),
        onPressed: () {
          onPress();
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Pallet.inner1,
              border: Border.all(color: Pallet.font3),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Pallet.font3),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.add,
                color: Pallet.font3,
                size: 18,
              )
            ],
          )),
        ));
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton({super.key, required this.label, required this.onPress});
  final String label;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
        minimumSize: Size(30, 30),
      ),
      onPressed: () {
        onPress();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Pallet.inner1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(color: Pallet.font3, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.color, required this.onSelect});
  final Color color;
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
  @override
  void initState() {
    selectedColor = widget.color;
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
    // server.get(
    //     refresh: true,
    //     lock: true,
    //     data: {"0": "get_colors"},
    //     func: (data) {
    //       defaultColors = data["default"];
    //       if (defaultColors.isNotEmpty) {
    //         selectedColor = Color(int.parse(defaultColors.first["color"]));
    //       }
    //       print(defaultColors);
    //       customColors = data["custom"];
    //       adding.notifyListeners();
    //       setState(() {});
    //     });
    // await server.lock();
    // server.release();
  }

  OverlayEntry _createDropDown() {
    return OverlayEntry(builder: (context) {
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
                          builder:
                              (BuildContext context, bool _, Widget? child) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Pallet.inner2,
                                  borderRadius: BorderRadius.circular(10)),
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
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: Pallet.inner3,
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                                          fontSize: 12),
                                                      // maxLines: maxLines ?? 1,
                                                      decoration:
                                                          InputDecoration(
                                                        // hintText: hintText,
                                                        hintStyle: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Pallet.font3),
                                                        isDense: true,
                                                        border:
                                                            InputBorder.none,
                                                      )),
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
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      AddButton(
                                        onPress: () {
                                          if (adding.value) {
                                            String hash =
                                                color.text.replaceAll("#", "");
                                            if (hash.length == 6) {
                                              hash = "0xFF" + hash;
                                            }
                                            // server.get(
                                            //     data: {"0": "add_color", "1": hash},
                                            //     func: (value) {
                                            //       request.add("get_colors");
                                            //     });
                                          } else {
                                            adding.value = true;
                                            setState(() {});
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
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
                                  Text(
                                    "colors",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Wrap(
                                    children: [
                                      for (var color in defaultColors)
                                        InkWell(
                                          onTap: () {
                                            selectedColor = Color(
                                                int.parse(color["color"]));
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
                                                    int.parse(color["color"])),
                                                // color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (customColors.isNotEmpty)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "colors",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Wrap(
                                          children: [
                                            for (var color in customColors)
                                              InkWell(
                                                onTap: () {
                                                  selectedColor = Color(
                                                      int.parse(
                                                          color["color"]));
                                                  widget.onSelect(color);
                                                  close();
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(5),
                                                  width: 26,
                                                  height: 26,
                                                  decoration: BoxDecoration(
                                                      color: Color(int.parse(
                                                          color["color"])),
                                                      // color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                              )
                                          ],
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            );
                          }),
                    ),
                  )),
            ],
          ),
        ),
      );
    });
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
          Overlay.of(context)!.insert(dropdown!);
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
            color: selectedColor, borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}

class MultiSelect extends StatefulWidget {
  const MultiSelect(
      {super.key,
      required this.label,
      required this.items,
      required this.itemKey,
      required this.onChanged,
      // required this.onPress,
      this.itemHeight = 40,
      this.menuDecoration});
  final String label;
  final List<Map> items;
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
    return OverlayEntry(builder: (context) {
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
                height: widget.itemHeight * widget.items.length,
                child: Material(
                  elevation: 60,
                  color: Colors.transparent,
                  child: ValueListenableBuilder<int?>(
                      valueListenable: hoveredIdx,
                      builder: (BuildContext context, int? _hoveredIdx,
                          Widget? child) {
                        return Container(
                            decoration: widget.menuDecoration,
                            child: ListView(children: [
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
                                      widget.items[i]["selected"] =
                                          !widget.items[i]["selected"];
                                      hoveredIdx.notifyListeners();

                                      widget.onChanged(widget.items[i]);
                                      // if (widget.items[i]["selected"] == true) {
                                      // widget.items[i]["selected"] = false;
                                      // for (var i = 0; i < ticket.selectedUsers.length; i++) {
                                      // if (item["userId"] == ticket.selectedUsers[i]["userId"]) {
                                      // ticket.selectedUsers.removeAt(i);
                                      // }
                                      // }
                                      // } else {
                                      // ticket.selectedUsers.add(item);
                                      // item["selected"] = true;
                                      // }
                                      // notifier.notifyListeners();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: (i == _hoveredIdx)
                                            ? Pallet.inner3
                                            : Colors.transparent,
                                      ),
                                      height: widget.itemHeight,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          ProfileIcon(
                                            size: 25,
                                            name: widget.items[i]["userName"],
                                            color: Color(int.parse(
                                                widget.items[i]["color"])),
                                            // color: Color(int.parse(item["color"].toString(), radix: 16)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              widget.items[i]["userName"],
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          Expanded(child: SizedBox()),
                                          InkWell(
                                            onTap: () {},
                                            child: Container(),
                                          ),
                                          Checkbox(
                                              activeColor: Pallet.inner2,
                                              value: widget.items[i]
                                                  ["selected"],
                                              onChanged: (value) {
                                                widget.items[i]["selected"] =
                                                    value;
                                                hoveredIdx.notifyListeners();
                                                widget
                                                    .onChanged(widget.items[i]);

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
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ]));
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    });
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
          Overlay.of(context)!.insert(dropdown!);
        }

        isOpen = !isOpen;
        setState(() {});
      },
      child: Container(
        key: actionKey,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Pallet.inner1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Text(
              widget.label,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  const DropDown(
      {super.key,
      required this.label,
      required this.items,
      required this.itemKey,
      required this.onPress,
      this.itemHeight = 40,
      this.menuDecoration});

  final String label;
  final List<Map> items;
  final String itemKey;
  final double itemHeight;
  final BoxDecoration? menuDecoration;
  final Function(Map) onPress;
  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
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
    return OverlayEntry(builder: (context) {
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
                  height: widget.itemHeight * widget.items.length,
                  child: Material(
                      elevation: 60,
                      color: Colors.transparent,
                      child: ValueListenableBuilder<int?>(
                          valueListenable: hoveredIdx,
                          builder: (BuildContext context, int? _hoveredIdx,
                              Widget? child) {
                            return Container(
                                // decoration: BoxDecoration(color: Colors.blue),
                                decoration: widget.menuDecoration,
                                child: ListView(children: [
                                  // for (var item in widget.items)
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
                                          print("object");
                                          widget.onPress(widget.items[i]);
                                          close();
                                        },
                                        child: Container(
                                          color: (i == _hoveredIdx)
                                              ? Pallet.inner3
                                              : Colors.transparent,
                                          height: widget.itemHeight,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  widget.items[i]
                                                      [widget.itemKey],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                ]));
                          })),
                ),
              ],
            ),
          ),
        ),
      );
    });
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
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Pallet.inner1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Text(
              widget.label,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class FilePreview extends StatelessWidget {
  const FilePreview(
      {super.key, required this.name, required this.size, this.url});
  final String name;
  final int size;
  final String? url;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Pallet.inner3,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Pallet.font3.withOpacity(0.5))),
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
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
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
                SizedBox(
                  height: 3,
                ),
                Text(
                  getSize(size),
                  style: TextStyle(fontSize: 10, color: Pallet.font3),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.download),
          SizedBox(
            width: 10,
          ),
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
      return "assets/file/green.svg";
    } else if (red.contains(fileType)) {
      return "assets/file/red.svg";
    } else if (yellow.contains(fileType)) {
      return "assets/file/yellow.svg";
    } else {
      return "assets/file/blue.svg";
    }
  }
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
            color: Pallet.inner1,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Pallet.font3)),
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

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class Parallax extends SingleChildRenderObjectWidget {
  const Parallax({
    super.key,
    required Widget background,
  }) : super(child: background);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderParallax(scrollable: Scrollable.of(context));
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderParallax renderObject) {
    renderObject.scrollable = Scrollable.of(context);
  }
}

class ParallaxParentData extends ContainerBoxParentData<RenderBox> {}

class RenderParallax extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin {
  RenderParallax({
    required ScrollableState scrollable,
  }) : _scrollable = scrollable;

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    if (value != _scrollable) {
      if (attached) {
        _scrollable.position.removeListener(markNeedsLayout);
      }
      _scrollable = value;
      if (attached) {
        _scrollable.position.addListener(markNeedsLayout);
      }
    }
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ParallaxParentData) {
      child.parentData = ParallaxParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;

    // Force the background to take up all available width
    // and then scale its height based on the image's aspect ratio.
    final background = child!;
    final backgroundImageConstraints =
        BoxConstraints.tightFor(width: size.width);
    background.layout(backgroundImageConstraints, parentUsesSize: true);

    // Set the background's local offset, which is zero.
    (background.parentData as ParallaxParentData).offset = Offset.zero;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Get the size of the scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;

    // Calculate the global position of this list item.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final backgroundOffset =
        localToGlobal(size.centerLeft(Offset.zero), ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final scrollFraction =
        (backgroundOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final background = child!;
    final backgroundSize = background.size;
    final listItemSize = size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
        background,
        (background.parentData as ParallaxParentData).offset +
            offset +
            Offset(0.0, childRect.top));
  }
}
